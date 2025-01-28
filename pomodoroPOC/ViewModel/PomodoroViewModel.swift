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
    
    
    var pomodoroEditable: Bool { !play }
    
    var pomodoroSingleton = PomodoroSingleton.shared
    var pomodoro: Pomodoro
    
    override init() {
        
        pomodoro = Pomodoro(restTime: 30, workTime: 30, Iteration: 1)
        
        super.init()
        
        clockText = formatTime(seconds: pomodoro.workTime)
        
        pomodoroSingleton.initialConfig(pomodoro) { clock, clockCentiSeconds, recover in
            self.clockText = self.formatTime(seconds: clock)
            
            self.progressCircle = self.calculateProgressPercentage(
                totalWorkTime: self.pomodoro.workTime,
                elapsedCentiSeconds: clockCentiSeconds
            )
            self.recover = recover
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
