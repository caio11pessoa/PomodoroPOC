//
//  PomodoroSingleton.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation

class PomodoroSingleton {
    
    private var timer: Timer?
    private var isRunning: Bool = false
    private var initialClock: Int?
    private init() {}
    private var clock: Int?
    
    static let shared = PomodoroSingleton()
    
    var updateClock: ((Int) -> Void)? // Dá pra colocar em uma interface
    
    func initialConfig(initialClock: Int, updateClock: ((Int) -> Void)? = nil) {
        clock = initialClock
        self.initialClock = initialClock
        self.updateClock = updateClock
    }
    
    func play() {
        guard !isRunning else { return }

        isRunning = true
        
        // Adaptar para 0.1 segundos :)
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard self.clock != nil else { return } // Clock n inicializado

            if self.clock == 0 {
                pause()
                resetClock()
                return
            }
            
            self.clock! -= 1
            
            if let updateClock = self.updateClock {
                updateClock(self.clock!)
            }
        }
    }
    
    func pause() {
        guard isRunning else { return }
        isRunning = false
        
        timer?.invalidate()
        timer = nil
    }
    
    func resetClock() {
        clock = initialClock
    }
}
