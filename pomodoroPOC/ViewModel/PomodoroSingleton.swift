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
    private var initialClockCentiSeconds: Int?
    private var clockCentiSeconds: Int?
    private var TrackClock: ((Int, Int) -> Void)? // Dá pra colocar em uma interface
    
    private init() {}
    static let shared = PomodoroSingleton()
    
    
    func initialConfig(initialClock: Int, updateClock: ((Int, Int) -> Void)? = nil) { // Ajeitar a lógica de receber em segundos
        
        clockCentiSeconds = initialClock * 100
        self.initialClockCentiSeconds = initialClock * 100
        self.TrackClock = updateClock

    }
    
    func play() {
        guard !isRunning else { return }
        
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { [weak self] _ in

            guard let self = self else { return }
            guard  self.clockCentiSeconds != nil else { return }
            
            let isClockOver = self.clockCentiSeconds == 0

            if isClockOver {
                pauseClock()
                resetClock()
                return
            }
            // 30 * 100 3000 Centseconds
            // 2999
            // 2998
            self.clockCentiSeconds! -= 1
            
            if let TrackClock = self.TrackClock {

                let clockSeconds = Double(self.clockCentiSeconds!)/100
                let clockSecondsCeil = Int(ceil(clockSeconds))

                TrackClock(clockSecondsCeil, self.clockCentiSeconds!)
            }
        }
    }
    
    func pauseClock() {
        guard isRunning else { return }
        isRunning = false
        
        timer?.invalidate()
        timer = nil
    }
    
    func updateClock(pomodoro: Pomodoro){
        initialClockCentiSeconds = pomodoro.workTime * 100
        resetClock()
    }
    
    func resetClock() {
        clockCentiSeconds = initialClockCentiSeconds
    }
}
