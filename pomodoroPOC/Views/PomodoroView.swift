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
                viewModel.backgroundColor
                    .ignoresSafeArea()
                VStack {
                    ZStack {
                        
                        CircularProgressView(percentagem: viewModel.progressCircle, isWorking: !viewModel.recover)
                            .animation(.easeInOut, value: viewModel.progressCircle)
                        
                        VStack {
                            
                            Text(viewModel.clockText)
                                .font(viewModel.agdasimaRegularFont(size: 64))
                                .foregroundStyle(viewModel.textColor)
                            
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
                        Text("EditButton", comment: "Text for edit button" )
                            .font(viewModel.agdasimaRegularFont(size: 32))
                            .foregroundStyle(viewModel.pomodoroEditable ? viewModel.textColor : .gray)
                    }.disabled(!viewModel.pomodoroEditable)
                }
            }
            .sheet(isPresented: $viewModel.sheetIsPresented) {
                EditPomodoroSheet(viewModel: viewModel)
            }
        }
        
    }
}


#Preview {
    PomodoroView()
}
