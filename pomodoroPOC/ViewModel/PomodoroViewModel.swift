//
//  ViewModel.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation
import Combine
import SwiftUI

class PomodoroViewModel: ObservableObject {
    @Published var clockText: String
    var pomodoroSingleton = PomodoroSingleton.shared
    var pomodoro: Pomodoro
    var progressCircle: Double
    
    init() {
        pomodoro = Pomodoro(restTime: 30, workTime: 30, Iteration: 1)
        progressCircle = 0
        clockText = ""
        clockText = self.formatTime(seconds: pomodoro.workTime)
        
        pomodoroSingleton.initialConfig(initialClock: pomodoro.workTime) { clock in
            self.clockText = self.formatTime(seconds: clock) // Vincula clockText com clock do singleton
            self.progressCircle = Double(self.pomodoro.workTime - clock) / Double(self.pomodoro.workTime)
        }
    }
    
    
    
    
    lazy var startPomodoro = pomodoroSingleton.play
    
    func stopPomodoro() {
        pomodoroSingleton.pause()
        pomodoroSingleton.resetClock()
        clockText = self.formatTime(seconds: pomodoro.workTime)
        progressCircle = 0
    }
    
    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
