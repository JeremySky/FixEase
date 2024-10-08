//
//  UpkeepDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import SwiftUI

struct UpkeepDetailView: View {
    
    @Binding var upkeep: Upkeep
    @Binding var sheetIsPresenting: Sheet?
    let saveUpkeepAction: (Upkeep) -> Void
    
    
    init(_ upkeep: Binding<Upkeep>, _ sheetIsPresenting: Binding<Sheet?>, saveUpkeepAction: @escaping (Upkeep) -> Void) {
        self._upkeep = upkeep
        self._sheetIsPresenting = sheetIsPresenting
        self.saveUpkeepAction = saveUpkeepAction
    }
    
    var body: some View {
        VStack(spacing: 40) {
            Button(action: { sheetIsPresenting = .modifyUpkeep(upkeep) }) {
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
                    ForEach(upkeep.notes) { note in
                        Button(action: { sheetIsPresenting = .modifyNote(note) }, label: {
                            Text(note.string)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        })
                    }
                    .onDelete(perform: { indexSet in
                        var updatedUpkeep = self.upkeep
                        updatedUpkeep.notes.remove(atOffsets: indexSet)
                        self.upkeep = updatedUpkeep
                        saveUpkeepAction(updatedUpkeep)
                    })
                    Button(action: { sheetIsPresenting = .newNote }, label: {
                        Text("+ New Note")
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color.greenDark)
                    })
                }
                .listStyle(.inset)
                .scrollIndicators(.hidden)
                
            }
        }
    }
}

#Preview {
    @State var upkeep = Upkeep.listCoffeeMaker[0]
    return UpkeepDetailView($upkeep, .constant(nil)) { _ in }
}
