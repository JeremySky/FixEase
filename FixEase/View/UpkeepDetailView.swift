//
//  UpkeepDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct UpkeepDetailView: View {
    
    @EnvironmentObject var manager: CollectionManager
    var upkeep: Upkeep
    
    init(_ upkeep: Upkeep) {
        self.upkeep = upkeep
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Button(action: { manager.modifyUpkeepSheet() }) {
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
                    ForEach(Array(upkeep.notes.enumerated()), id: \.offset) { offset, note in
                        Button(note) { manager.modifyNoteSheet(note, atIndex: offset) }
                            .foregroundStyle(.primary)
                            .buttonStyle(.borderless)
                    }
                    Button("+ New Note") { manager.newNoteSheet() }
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
    @State var manager = CollectionManager.preview
    return ItemDetailView($manager.collection[0])
        .background(Background())
        .environmentObject(manager)
}
