//
//  EditPomodoroSheet.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 31/01/25.
//

import SwiftUI

struct EditPomodoroSheet: View {
    @StateObject var viewModel: PomodoroViewModel
    var body: some View {
        ZStack {
            viewModel.backgroundColor
                .ignoresSafeArea()
            VStack {
                Text("FocusTimeSelect")
                    .font(viewModel.agdasimaRegularFont(size: 30))
                    .foregroundStyle(viewModel.textColor)
                    .padding(.top)
                
                Picker("Minutes", selection: $viewModel.workTime) {
                    ForEach(viewModel.intervaloMinutos, id: \.self) { minuto in
                        Text("\(minuto) min")
                            .tag(minuto)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                .frame(height: 150)
                
                Text("RestTimeSelect")
                    .font(viewModel.agdasimaRegularFont(size: 30))
                    .foregroundStyle(viewModel.textColor)
                    .padding(.top)
                
                Picker("Minutes", selection: $viewModel.restTime) {
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
                    Text("FinishButton")
                        .font(viewModel.agdasimaRegularFont(size: 42))
                        .foregroundStyle(viewModel.textColor)
                }
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.top)
            }
            .padding()
        }
    }
}

#Preview {
    EditPomodoroSheet(viewModel: PomodoroViewModel())
}
