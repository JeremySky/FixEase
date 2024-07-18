//
//  UpkeepRowView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct UpkeepRowView: View {
    
    let upkeep: (description: String, dueDate: Date, emoji: String)
    @State var isCompleted = false
    
    init(_ upkeep: (description: String, dueDate: Date, emoji: String), isCompleted: Bool = false) {
        self.upkeep = upkeep
        self.isCompleted = isCompleted
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundStyle(.white)
                .shadow(radius: 10)
            
            HStack {
                Spacer()
                Text(upkeep.emoji)
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
    let upkeep: (description: String, dueDate: Date, emoji: String) = (description: "Water Flowers", dueDate: Date(), emoji: "🌻")
    return UpkeepRowView(upkeep)
        .padding()
}
