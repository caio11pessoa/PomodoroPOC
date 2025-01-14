//
//  PomodoroSingleton.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation

/*
 class Singleton {

     /// The static field that controls the access to the singleton instance.
     ///
     /// This implementation let you extend the Singleton class while keeping
     /// just one instance of each subclass around.
     static var shared: Singleton = {
         let instance = Singleton()
         // ... configure the instance
         // ...
         return instance
     }()

     /// The Singleton's initializer should always be private to prevent direct
     /// construction calls with the `new` operator.
     private init() {}

     /// Finally, any singleton should define some business logic, which can be
     /// executed on its instance.
     func someBusinessLogic() -> String {
         // ...
         return "Result of the 'someBusinessLogic' call"
     }
 }
 */

import Foundation

class PomodoroSingleton {
    var clock: Int = 0
    var timer: Timer?
    var isRunning: Bool = false
    static let shared = PomodoroSingleton()
    
    private init() {}
    
    func play() {
        guard !isRunning else { return }
        isRunning = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [weak self] _ in
            guard let self = self else { return }
            self.clock += 1
            print("Clock: \(self.clock)")
        }
    }
    
    func pause() {
        guard isRunning else { return }
        isRunning = false
        
        timer?.invalidate()
        timer = nil
    }
    
    func resetClock() {
        clock = 0
        print("Clock reset to 0")
    }
}

