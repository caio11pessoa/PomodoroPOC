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
                        Button {
                            !viewModel.play ? viewModel.startPomodoro() : viewModel.pausePomodoro()
                            withAnimation(.easeInOut.speed(0.7)) {
                                viewModel.play.toggle()
                            }
                        } label: {
                            Image(!viewModel.play ? "PlayPomodoro": "PausePomodoro")
                                .resizable()
                                .frame(width: 26, height: 26)
                        }
                        
                        
                        Button {
                            viewModel.stopPomodoro()
                            withAnimation(.easeInOut.speed(0.7)) {
                                viewModel.play = false
                            }
                        }label: {
                            Image("StopPomodoro")
                                .resizable()
                                .frame(width: 24, height: 26)
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    PomodoroView()
}
