//
//  ContentView.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PomodoroViewModel()
    var backgroundColor = Color(red: 253/255, green: 241/255, blue: 218/255)
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(backgroundColor)
                    .ignoresSafeArea()
                CircularProgressView(percentagem: Double( viewModel.progressCircle))
                    .animation(.smooth.delay(5), value: viewModel.progressCircle)
                VStack {
                    NavigationLink("Tela2", destination:
                                    VStack{
                        Text("Tela2")
                    }
                        .navigationTitle(viewModel.clockText)
                    )
                    Spacer()
                    ZStack {
                        Text(viewModel.clockText)
                            .font(.custom("Agdasima-Regular", size: 65))
                    }
                    Spacer()
                    HStack {
                        Button("Começar") {
                            viewModel.startPomodoro()
                        }
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        
                        Button("Parar") {
                            viewModel.stopPomodoro()
                        }
                        .padding()
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
    ContentView()
}
