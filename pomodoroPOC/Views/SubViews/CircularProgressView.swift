//
//  CircularProgressView.swift
//  pomodoroPOC
//
//  Created by Caio de Almeida Pessoa on 15/01/25.
//

import SwiftUI

struct CircularProgressView: View {
    private var percentagem: Double = 0.25
    private var maxAngle: Double = 360
    private var progress: Double { percentagem*(maxAngle/maxAngle)
    }
    private var lineWidth: CGFloat = 6
    
    init(percentagem: Double) {
        self.percentagem = percentagem
    }
    private var circleProgress: some View {
        ZStack{
            Circle()
                .stroke(
                    Color("ColorCircleUnprogress"),
                    lineWidth: lineWidth
                )
                .padding()
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    Color("ColorCircleProgress"),
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
            .padding(50)
    }
}

#Preview {
    CircularProgressView(percentagem: 0.1)
}
