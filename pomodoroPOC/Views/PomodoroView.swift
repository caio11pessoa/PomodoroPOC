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
                Color(viewModel.recover ? "BackgroundRest" :  "Background")
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        
                        CircularProgressView(percentagem: viewModel.progressCircle, isWorking: !viewModel.recover)
                            .animation(.easeInOut, value: viewModel.progressCircle)
                        
                        VStack {
                            
                            Text(viewModel.clockText)
                                .font(.custom("Agdasima-Regular", size: 65))
                                .foregroundStyle(Color(viewModel.recover ? "TextColorPrimaryRest" :  "TextColorPrimary"))
                            
                            HStack {
                                Button {
                                    !viewModel.play ? viewModel.startPomodoro() : viewModel.pausePomodoro()
                                } label: {
                                    Image(
                                        !viewModel.play ?
                                        viewModel.recover ? "PlayPomodoroRest" : "PlayPomodoro":
                                            viewModel.recover ? "PausePomodoroRest" : "PausePomodoro"
                                    )
                                    .resizable()
                                    .frame(width: 26, height: 26)
                                }
                                
                                Button {
                                    viewModel.stopPomodoro()
                                }label: {
                                    Image(viewModel.recover ? "StopPomodoroRest" : "StopPomodoro")
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
                            .foregroundStyle(viewModel.pomodoroEditable ? Color(viewModel.recover ? "TextColorPrimaryRest" :  "TextColorPrimary") : .gray)
                    }.disabled(!viewModel.pomodoroEditable)
                }
            }
            .sheet(isPresented: $viewModel.sheetIsPresented) {
                ZStack {
                    Color(viewModel.recover ? "BackgroundRest" :  "Background")
                        .ignoresSafeArea()
                    VStack {
                        Text("Selecione o tempo de trabalho")
                            .font(.custom("Agdasima-Regular", size: 30))
                            .foregroundStyle(Color(viewModel.recover ? "TextColorPrimaryRest" :  "TextColorPrimary"))
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
                            .foregroundStyle(Color(viewModel.recover ? "TextColorPrimaryRest" :  "TextColorPrimary"))
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
                                .foregroundStyle(Color(viewModel.recover ? "TextColorPrimaryRest" :  "TextColorPrimary"))
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
