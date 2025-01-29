//
//  PomodoroSingleton.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation

class PomodoroSingleton {
    
    private var timer: Timer?
    var isRunning: Bool = false
    private var initialClockCentiSeconds: Int?
    private var initialRestTimeCentiSeconds: Int?
    private var clockCentiSeconds: Int?
    private var TrackClock: ((Int, Int, Bool, Bool) -> Void)? // Dá pra colocar em uma interface
    var recover: Bool = false
    
    private init() {}
    static let shared = PomodoroSingleton()
    
    
    func initialConfig(_ pomodoro: Pomodoro, updateClock: ((Int, Int, Bool, Bool) -> Void)? = nil) { // Ajeitar a lógica de receber em segundos
        
        clockCentiSeconds = pomodoro.workTime * 100
        self.initialClockCentiSeconds = pomodoro.workTime * 100
        self.initialRestTimeCentiSeconds = pomodoro.restTime * 100
        self.TrackClock = updateClock
        
    }
    
    func play() {
        guard !isRunning else { return }
        recover = false
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            
            guard let self = self else { return }
            guard  self.clockCentiSeconds != nil else { return }
            
            let isClockOver = self.clockCentiSeconds == 0
            
            if isClockOver {
                recover = true
                pauseClock()
                resetClock()
                playRecover()
                return
            }
            
            self.clockCentiSeconds! -= 1
            
            if let TrackClock = self.TrackClock {
                
                let clockSeconds = Double(self.clockCentiSeconds!)/100
                let clockSecondsCeil = Int(ceil(clockSeconds))
                
                TrackClock(clockSecondsCeil, self.clockCentiSeconds!, recover, isRunning)
            }
        }
    }
    
    func playRecover() {
        guard !isRunning else { return }
        recover = true
        
        
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in
            
            guard let self = self else { return }
            guard  self.clockCentiSeconds != nil else { return }
            
            let isClockOver = self.clockCentiSeconds == 0
            
            if isClockOver {
                recover = false
                pauseClock()
                resetClock()
                if let TrackClock = self.TrackClock {
                    
                    let clockSeconds = Double(self.clockCentiSeconds!)/100
                    let clockSecondsCeil = Int(ceil(clockSeconds))
                    
                    TrackClock(clockSecondsCeil, self.clockCentiSeconds!, recover, isRunning)
                }
                return
            }
            
            self.clockCentiSeconds! -= 1
            
            if let TrackClock = self.TrackClock {
                
                let clockSeconds = Double(self.clockCentiSeconds!)/100
                let clockSecondsCeil = Int(ceil(clockSeconds))
                
                TrackClock(clockSecondsCeil, self.clockCentiSeconds!, recover, isRunning)
            }
        }
    }
    
    func pauseClock() {
        guard isRunning else { return }
        isRunning = false
        print("PAUSE \(isRunning)")
        
        timer?.invalidate()
        timer = nil
    }
    
    func updateClock(pomodoro: Pomodoro){
        initialClockCentiSeconds = pomodoro.workTime * 100
        resetClock()
    }
    
    func resetClock() {
        if recover {
            clockCentiSeconds = initialRestTimeCentiSeconds
        }else {
            clockCentiSeconds = initialClockCentiSeconds
        }
    }
}
