//
//  PomodoroHelpers.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 18/01/25.
//

import Foundation

class PomodoroHelpers {
    func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func calculateProgressPercentage(totalWorkTime: Int, elapsedCentiSeconds: Int) -> Double {
        let totalWorkTimeInCentiSeconds = Double(totalWorkTime * 10)
        let remainingWorkTimeInCentiSeconds = totalWorkTimeInCentiSeconds - Double(elapsedCentiSeconds)
        return remainingWorkTimeInCentiSeconds / totalWorkTimeInCentiSeconds
    }
}
