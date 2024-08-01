//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

struct ItemDetailView: View {
    
    @EnvironmentObject var manager: CollectionManager
    @Binding var item: Item
    @State var upkeepIndex: Int = 0
    
    init(_ item: Binding<Item>) {
        self._item = item
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Back") { manager.selectedItem = nil }
                    Spacer()
                    Button("New Upkeep") { manager.modifyUpkeep = Upkeep() }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                
                //MARK: -- Item Details...
                Button(action: { manager.modifyItemSheet() }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 3) {
                            Text(item.name)
                                .font(.title2.weight(.heavy))
                                .foregroundStyle(Color.greenDark)
                            Text(item.description)
                                .font(.caption)
                                .foregroundStyle(.gray)
                                .padding(.bottom, 10)
                            Text("\(item.upkeeps.count) Upkeeps")
                                .font(.largeTitle.weight(.black).width(.compressed))
                                .foregroundStyle(Color.black.opacity(0.8))
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Text(item.emoji)
                            .font(.custom("Item Emoji", fixedSize: 80))
                            .padding(.trailing)
                    }
                    .padding(.top, 2)
                    .padding(.bottom, 4)
                    .background(
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(LinearGradient(colors: [.white, .clear], startPoint: .center, endPoint: .trailing))
                            Spacer().frame(width: 5)
                        }
                            .shadow(radius: 10, x: -5, y: 5)
                    )
                }
                .padding()
                
                Spacer().frame(height: 60)
                
                ZStack {
                    if !item.upkeeps.isEmpty {
                        UpkeepDetailView(item.upkeeps[upkeepIndex])
                        UpkeepIndexStepper($upkeepIndex, for: item)
                            .onChange(of: upkeepIndex) { _, newValue in
                                manager.select(upkeepAtIndex: newValue)
                            }
                    } else {
                        VStack {
                            Text("EMPTY")
                            Spacer()
                        }
                    }
                }
            }
            
            
            //MARK: -- Custom Sheet for ModifyNoteView...
            if let originalNote = manager.selectedNote?.value {
                ModifyNoteView(originalNote) { updatedNote in
                    originalNote.isEmpty ? manager.add(note: updatedNote) : manager.update(note: updatedNote)
                }
            }
        }
        .sheet(item: $manager.modifyUpkeep) { upkeep in
            ModifyUpkeepView(upkeep, submit: { upkeep.isEmpty ? manager.add(upkeep: $0) : manager.update(upkeep: $0) })
        }
        .sheet(item: $manager.modifyItem) { itemToModify in
            ModifyItemView(itemToModify, submit: { manager.update(item: $0) })
        }
    }
}



#Preview {
    ContentView(collectionManager: CollectionManager.preview)
}
