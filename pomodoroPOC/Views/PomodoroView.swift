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
                VStack {
                    ZStack {
                        
                        CircularProgressView(percentagem: viewModel.progressCircle)
                            .animation(.easeInOut, value: viewModel.progressCircle)
                        
                        VStack {
                            Text(viewModel.clockText)
                                .font(.custom("Agdasima-Regular", size: 65))
                                .foregroundStyle(Color("TextColorPrimary"))
                            
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
                    Button {
                        viewModel.sheetIsPresented = true
                    } label: {
                        Text("Editar")
                            .font(.custom("Agdasima-Regular", size: 32))
                            .foregroundStyle(viewModel.pomodoroEditable ? Color("TextColorPrimary") : .gray)
                    }.disabled(!viewModel.pomodoroEditable)
                }
            }
            .sheet(isPresented: $viewModel.sheetIsPresented) {
                ZStack {
                    Color("Background")
                        .ignoresSafeArea()
                    VStack {
                        Text("Selecione o tempo de trabalho")
                            .font(.custom("Agdasima-Regular", size: 30))
                            .foregroundStyle(Color("TextColorPrimary"))
                            .padding(.top)
                        
                        Picker("Minutos", selection: $viewModel.workTime) {
                            ForEach(viewModel.intervaloMinutos, id: \.self) { minuto in
                                Text("\(minuto) min")
                                    .tag(minuto)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 150)
                        
                        Text("Selecione o tempo de descanso")
                            .font(.custom("Agdasima-Regular", size: 30))
                            .foregroundStyle(Color("TextColorPrimary"))
                            .padding(.top)
                        
                        Picker("Minutos", selection: $viewModel.restTime) {
                            ForEach(viewModel.intervaloMinutos, id: \.self) { minuto in
                                Text("\(minuto) min")
                                    .tag(minuto)
                            }
                        }
                        .pickerStyle(WheelPickerStyle())
                        .frame(height: 150)
                        
                        
                        Button(action: {
                            viewModel.sheetIsPresented = false
                            viewModel.updateSettings()
                        }) {
                            Text("Concluir")
                                .font(.custom("Agdasima-Regular", size: 42))
                                .foregroundStyle(Color("TextColorPrimary"))
                        }
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.top)
                    }
                    .padding()
                }
            }
        }
        
    }
}


#Preview {
    PomodoroView()
}
