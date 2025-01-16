//
//  PomodoroSingleton.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation

class PomodoroSingleton {
    
    var clock: Int = 25
    var isRunning: Bool = false
    private var timer: Timer?
    static let shared = PomodoroSingleton()
    
    private init() {}
    
    func play() {
        guard !isRunning else { return } // Verifica se já começou
        isRunning = true // seta para isRunning
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            if self.clock == 0 { // encerra o clock
                pause()
                resetClock()
                return
            }
            self.clock -= 1 // Decrementa
            print("Clock on Singleton: \(self.clock)")
        }
    }
    
    func pause() {
        guard isRunning else { return }
        isRunning = false
        
        timer?.invalidate()
        timer = nil
    }
    
    func resetClock() {
        clock = 25
        print("Clock reset to 25")
    }
}
