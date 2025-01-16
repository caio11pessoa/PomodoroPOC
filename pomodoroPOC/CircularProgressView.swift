//
//  CircularProgressView.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 15/01/25.
//

import SwiftUI

// caso de 25%
struct CircularProgressView: View {
    init(percentagem: Double) {
        self.percentagem = percentagem
    }
    // 360 -> Completo
    // 90 -> 25% -> 0.25
    var percentagem: Double = 0.25
    private var maxAngle: Double = 360
    private var progress: Double{ percentagem*maxAngle/maxAngle }
    private var lineWidth: CGFloat = 6
    private var colorProgress: Color = Color(red: 27/255, green: 23/255, blue: 17/255)
    private var colorUnProgress: Color = Color(red: 186/255, green: 175/255, blue: 154/255)
    private var circleProgress: some View {
        ZStack{
            Circle()
                .stroke(
                    colorUnProgress,
                    lineWidth: lineWidth
                )
                .padding()
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    colorProgress,
                    style: StrokeStyle(
                        lineWidth: lineWidth,
                        lineCap: .round
                    )
                )
                .rotationEffect(.degrees(-90))
                .padding()
            HStack{
                Spacer()
                Circle()
                    .frame(width: 15)
                    .overlay {
                        Circle()
                            .foregroundStyle(.white)
                            .frame(width: 7)
                    }
                    .padding(8)
            }
            .rotationEffect(.degrees(-90 + percentagem*maxAngle))
        }
    }
    var body: some View {
        circleProgress
            .frame(width: 260)
    }
}

#Preview {
    CircularProgressView(percentagem: 0.1)
}
