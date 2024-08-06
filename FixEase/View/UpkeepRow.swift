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
    
    init(_ upkeep: Upkeep, isCompleted: Binding<Bool>, action: @escaping () -> Void) {
        self.upkeep = upkeep
        self._isCompleted = isCompleted
        self.action = action
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
                })
                .disabled(isCompleted)
            }
            .padding()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 115)
    }
}

#Preview {
    UpkeepRow(.listRocketShip[0], isCompleted: .constant(false)) {}
        .padding()
}
