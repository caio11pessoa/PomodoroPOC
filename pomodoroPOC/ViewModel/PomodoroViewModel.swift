//
//  ViewModel.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation
import Combine
import SwiftUI

class PomodoroViewModel: PomodoroHelpers, ObservableObject {
    
    @Published var clockText: String = ""
    @Published var play: Bool = false
    @Published var progressCircle: Double = 0
    @Published var sheetIsPresented: Bool = false
    @Published var workTime: Int = 30
    @Published var restTime: Int = 15
    @Published var recover: Bool = false
    let intervaloMinutos = stride(from: 5, to: 125, by: 5).map { $0 }
    
    var textColor: Color {Color(recover ? "TextColorPrimaryRest" :  "TextColorPrimary")}
    var backgroundColor: Color {Color(recover ? "BackgroundRest" :  "Background")}
    func agdasimaRegularFont(size: CGFloat) -> Font {Font.custom("Agdasima-Regular", size: size)}
    
    
    var pomodoroEditable: Bool { !play }
    
    var pomodoroSingleton = PomodoroSingleton.shared
    var pomodoro: Pomodoro
    
    override init() {
        
        pomodoro = Pomodoro(restTime: 15, workTime: 30, Iteration: 1)
        
        super.init()
        
        clockText = formatTime(seconds: pomodoro.workTime)
        
        pomodoroSingleton.initialConfig(pomodoro) { clock, clockCentiSeconds, recover, isRunning in
            let pomodoroViewModel = self
            
            pomodoroViewModel.clockText = pomodoroViewModel.formatTime(seconds: clock)
            
            pomodoroViewModel.progressCircle = pomodoroViewModel.calculateProgressPercentage(
                totalWorkTime: pomodoroViewModel.recover ? pomodoroViewModel.pomodoro.restTime:  pomodoroViewModel.pomodoro.workTime,
                elapsedCentiSeconds: clockCentiSeconds
            )
            pomodoroViewModel.recover = recover
            pomodoroViewModel.play = isRunning
        }
    }
    
    func startPomodoro() {
        self.play = true
        if recover {
            pomodoroSingleton.playRecover()
        }else {
            pomodoroSingleton.play()
        }
    }
    func pausePomodoro() {
        self.play = false
        pomodoroSingleton.pauseClock()
    }
    
    func stopPomodoro() {
        self.play = false
        pomodoroSingleton.pauseClock()
        pomodoroSingleton.resetClock()
        clockText = formatTime(seconds: pomodoro.workTime)
        progressCircle = 0
    }
    
    func updateSettings() {
        pomodoro.workTime = workTime*60
        pomodoro.restTime = restTime*60
        pomodoroSingleton.updateClock(pomodoro: pomodoro)
        clockText = formatTime(seconds: workTime*60)
    }
}
