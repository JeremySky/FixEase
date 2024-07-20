//
//  UpkeepRowView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct UpkeepRowView: View {
    
    let upkeep: Upkeep
    @State var isCompleted = false
    let action: () -> Void
    
    init(_ upkeep: Upkeep, isCompleted: State<Bool> = .init(initialValue: false), action: @escaping () -> Void) {
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
                        .font(.title3)
                        .fontWeight(.bold)
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
        .frame(width: .infinity, height: 115)
    }
}

#Preview {
    UpkeepRowView(Upkeep.listRocketShip[0]) {}
        .padding()
}
