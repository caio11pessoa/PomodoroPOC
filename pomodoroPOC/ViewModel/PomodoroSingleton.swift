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
    private var initialClockMili: Int?
    private init() {}
    private var clock: Int?
    private var clockMili: Int?
    
    static let shared = PomodoroSingleton()
    
    var updateClock: ((Int, Int) -> Void)? // Dá pra colocar em uma interface
    
    func initialConfig(initialClock: Int, updateClock: ((Int, Int) -> Void)? = nil) {
        clock = initialClock
        clockMili = initialClock * 100
        self.initialClock = initialClock
        self.initialClockMili = initialClock * 100
        self.updateClock = updateClock
    }
    
    func play() {
        guard !isRunning else { return }
        
        isRunning = true
        
        // Adaptar para 0.1 segundos :)
        // ->
//        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            guard self.clock != nil else { return } // Clock n inicializado
//            
//            if self.clock == 0 {
//                pause()
//                resetClock()
//                return
//            }
//            
//            self.clock! -= 1
//            
//            if let updateClock = self.updateClock {
//                updateClock(self.clock!)
//            }
//        }
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            guard self.clock != nil || self.clockMili != nil else { return } // Clock n inicializado
            
            if self.clockMili == 0 {
                pause()
                resetClock()
                return
            }
            
            self.clock! -= 1
            self.clockMili! -= 1
            
            if let updateClock = self.updateClock {
                let cloc = Double(self.clockMili!)/100
                updateClock(Int(ceil(cloc)), self.clockMili!)
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
        clockMili = initialClockMili
    }
}
