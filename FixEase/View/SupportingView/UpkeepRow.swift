//
//  UpkeepRowView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct UpkeepRow: View {
    
    let upkeep: Upkeep
    @Binding var isCompleted: Bool
    let action: () -> Void
    @State var animationAmount: CGFloat
    let startWithAnimation: Bool
    
    init(_ upkeep: Upkeep, isCompleted: Binding<Bool>, startWithAnimation: Bool = false, action: @escaping () -> Void) {
        self.upkeep = upkeep
        self._isCompleted = isCompleted
        self.action = action
        self.animationAmount = 1
        self.startWithAnimation = startWithAnimation
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 10)
            
            HStack {
                Spacer()
                Text(upkeep.emoji ?? "❔")
                    .font(.custom("background image", fixedSize: 100))
                    .opacity(isCompleted ? 0.25 : 0.6)
                Spacer().frame(width: 60)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(upkeep.description)
                        .font(.title3.weight(.bold))
                        .foregroundStyle(Color.greenDark)
                    HStack(spacing: 0) {
                        Text("\(upkeep.dueDate, format: .dateTime.weekday()) ")
                        Text(upkeep.dueDate, format: .dateTime.day().month().year())
                    }
                    .font(.caption)
                    .foregroundStyle(.gray)
                }
                .strikethrough(isCompleted)
                .opacity(isCompleted ? 0.6 : 1)
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        isCompleted = true
                        action()
                    }
                },
                       label: {
                    Image(systemName: isCompleted ? "checkmark.square" : "square")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 25)
                        .foregroundStyle(Color.greenLight)
                        .bold(isCompleted)
                        .overlay(
                            RoundedRectangle(cornerRadius: 3)
                                .stroke(.greenLight)
                                .scaleEffect(isCompleted ? 0 : animationAmount)
                                .opacity(isCompleted ? 0 : (1.7 - animationAmount))
                                .animation(
                                    !isCompleted ? .easeOut(duration: 1).repeatForever(autoreverses: false) : .default,
                                    value: animationAmount
                                )
                        )
                })
                .disabled(isCompleted)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 115)
        .onAppear() {
            if startWithAnimation {
                animationAmount = 1.7
            }
        }
    }
}

#Preview {
    @State var isCompleted: Bool = false
    return UpkeepRow(Upkeep.listRocketShip[0], isCompleted: $isCompleted) {}
        .padding()
}
