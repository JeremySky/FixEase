//
//  UpkeepDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct UpkeepDetailView: View {
    
    @EnvironmentObject var viewManager: ViewManager
    var upkeep: Upkeep
    let itemID: UUID
    
    init(forUpkeepIn item: Item, at index: Int) {
        self.upkeep = item.upkeeps[index]
        self.itemID = item.id
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Button(action: { viewManager.sheet = .modifyUpkeep(upkeep, itemID)}) {
                VStack {
                    Text(upkeep.description)
                        .font(.title2.weight(.bold))
                        .foregroundStyle(Color.greenDark)
                    Text("every \(upkeep.cycle.description)")
                        .fontWeight(.semibold)
                        .foregroundStyle(.gray)
                    Text("\(upkeep.dueDate, format: .dateTime.weekday(.wide)) \(upkeep.dueDate, format: .dateTime.day().month().year())")
                        .font(.caption)
                        .foregroundStyle(.gray)
                }
            }
            
            VStack(alignment: .leading) {
                Text("Notes:")
                    .bold()
                    .padding(.horizontal)
                List {
                    ForEach(upkeep.notes, id: \.self) { note in
                        Button(note) {
                            viewManager.modifyNote = note
                        }
                        .foregroundStyle(.primary)
                        .buttonStyle(.borderless)
                    }
                    Button("+ New Note") {
                        viewManager.modifyNote = ""
                    }
                    .foregroundStyle(Color.greenDark)
                    .buttonStyle(.borderless)
                }
                .listStyle(.inset)
                .scrollIndicators(.hidden)
                
            }
        }
    }
}

#Preview {
    UpkeepDetailView(forUpkeepIn: Item.exRocketShip, at: 0)
}
