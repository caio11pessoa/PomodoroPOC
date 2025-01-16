//
//  ViewModel.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import Foundation
import Combine

class PomodoroViewModel: ObservableObject {
    @Published var clockText: String = "25:00" // Estado para exibir o tempo

    private var cancellables = Set<AnyCancellable>()
    var pomodoro = PomodoroSingleton.shared
    var progressCircle: Double {
        print(pomodoro.clock, "CLOCK")
        return (Double(25 - pomodoro.clock) / 25) // se atentar a esse 25 aí
    }
    func startPomodoro() {
        pomodoro.play()
        startClockUpdate()
        print("Pomodoro started")
    }
    
    func stopPomodoro() {
        pomodoro.pause()
        pomodoro.resetClock()
        clockText = "00:00"
        print("Pomodoro stopped and clock reset")
    }

    func startClockUpdate() { // Essa lógica está ruim
        // Atualizar o `clockText` em tempo real
        Timer.publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.clockText = self.formatTime(seconds: self.pomodoro.clock)
            }
            .store(in: &cancellables) // Entender isso
    }

    private func formatTime(seconds: Int) -> String {
        let minutes = seconds / 60
        let seconds = seconds % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
}
