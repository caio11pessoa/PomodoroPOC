//
//  ContentView.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 13/01/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = PomodoroViewModel()
    
    var body: some View {
        NavigationStack {
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
                        .font(.custom("Agdasima-Bold", size: 65))
                        .bold()
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
            .padding()
        }
    }
}


#Preview {
    ContentView()
}
