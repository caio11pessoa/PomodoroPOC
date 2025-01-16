//
//  ContentView.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import SwiftUI

struct PomodoroView: View {
    @StateObject var viewModel = PomodoroViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("Background")
                    .ignoresSafeArea()
                
                CircularProgressView(percentagem: viewModel.progressCircle)
                    .animation(.easeInOut, value: viewModel.progressCircle)
                
                VStack {
                    ZStack {
                        Text(viewModel.clockText)
                            .font(.custom("Agdasima-Regular", size: 65))
                            .foregroundStyle(Color("TextColorPrimary"))
                    }
                    
                    HStack {
                        Button("Começar") {
                            viewModel.startPomodoro()
                        }
                        .padding(8)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Parar") {
                            viewModel.stopPomodoro()
                        }
                        .padding(8)
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                    }
                }
            }
        }
    }
}


#Preview {
    PomodoroView()
}
