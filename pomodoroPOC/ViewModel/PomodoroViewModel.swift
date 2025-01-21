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
    @Published var sheetIsPresented: Bool = true
    @Published var workTime: Int = 30
    @Published var restTime: Int = 15
    let intervaloMinutos = stride(from: 5, to: 125, by: 5).map { $0 }
    
    
    var pomodoroEditable: Bool {
        play != true
    }
     
    var pomodoroSingleton = PomodoroSingleton.shared
    var pomodoro: Pomodoro
    
    override init() {
        
        pomodoro = Pomodoro(restTime: 30, workTime: 60*5, Iteration: 1)
        
        super.init()
        
        clockText = formatTime(seconds: pomodoro.workTime)
        
        pomodoroSingleton.initialConfig(initialClock: pomodoro.workTime) { clock, clockCentiSeconds in
            self.clockText = self.formatTime(seconds: clock)
            
            self.progressCircle = self.calculateProgressPercentage(
                totalWorkTime: self.pomodoro.workTime,
                elapsedCentiSeconds: clockCentiSeconds
            )
        }
    }
    
    lazy var startPomodoro = pomodoroSingleton.play
    lazy var pausePomodoro = pomodoroSingleton.pauseClock
    
    func stopPomodoro() {
        pomodoroSingleton.pauseClock()
        pomodoroSingleton.resetClock()
        clockText = formatTime(seconds: pomodoro.workTime)
        progressCircle = 0
    }
    
    func updateSettings() {
        pomodoro.workTime = workTime
        pomodoro.restTime = restTime
        clockText = formatTime(seconds: pomodoro.workTime)
    }
}
