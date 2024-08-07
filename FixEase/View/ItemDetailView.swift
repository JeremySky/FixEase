//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

extension Binding where Value == Bool {
    init(sheet: Binding<Sheet?>) {
        self.init {
            switch sheet.wrappedValue?.type {
            case nil, .modifyNote, .newNote:
                return false
            default:
                return true
            }
        } set: { newValue in
            if !newValue { sheet.wrappedValue = nil }
        }

    }
}

enum Sheet: Equatable {
    static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        lhs.type == rhs.type
    }
    case modifyItem(Item), newUpkeep, modifyUpkeep(Upkeep), newNote, modifyNote(Note)
    
    var type: SheetType {
        switch self {
        case .modifyItem(_):
                .modifyItem
        case .newUpkeep:
                .newUpkeep
        case .modifyUpkeep(_):
                .modifyUpkeep
        case .newNote:
                .newNote
        case .modifyNote(_):
                .modifyNote
        }
    }
    
    var value: (any Identifiable)? {
        switch self {
        case .modifyItem(let item):
            item as Item
        case .newUpkeep:
            nil
        case .modifyUpkeep(let upkeep):
            upkeep as Upkeep
        case .newNote:
            nil
        case .modifyNote(let note):
            note as Note
        }
    }
    
    enum SheetType {
        case modifyItem, newUpkeep, modifyUpkeep, newNote, modifyNote
    }
}


struct ItemDetailView: View {
    
    @ObservedObject var viewModel: MainViewModel
    @Binding var item: Item
    @Binding var selectedItemID: UUID?
    @State var sheetIsPresenting: Sheet?
    @State var upkeepIndex: Int = 0
    
    init(_ item: Binding<Item>, _ selectedItemID: Binding<UUID?>, sheetIsPresenting: Sheet? = nil, viewModel: MainViewModel) {
        self._item = item
        self._selectedItemID = selectedItemID
        self.sheetIsPresenting = sheetIsPresenting
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button("Back") { selectedItemID = nil }
                    Spacer()
                    if !item.upkeeps.isEmpty {
                        Button("New Upkeep") { sheetIsPresenting = .newUpkeep }
                    }
                }
                .padding(.horizontal)
                .foregroundStyle(.white)
                
                //MARK: -- Item Details...
                Button(action: { sheetIsPresenting = .modifyItem(item) }) {
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
                                .foregroundStyle(Color.gray)
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
                        UpkeepDetailView($item.upkeeps[upkeepIndex], $sheetIsPresenting)
                        UpkeepIndexStepper($upkeepIndex, for: item)
                    } else {
                        EmptyView(newUpkeep: { sheetIsPresenting = .newUpkeep })
                    }
                }
            }
        }
        .overlay {
            if sheetIsPresenting?.type == .newNote || sheetIsPresenting?.type == .modifyNote {
                ModifyNoteView(sheetIsPresenting?.value as! Note?, $sheetIsPresenting) { note in
                        if let i = item.upkeeps[upkeepIndex].notes.firstIndex(where: { $0.id == note.id }) {
                            item.upkeeps[upkeepIndex].notes[i] = note
                        } else {
                            item.upkeeps[upkeepIndex].notes.append(note)
                        }
                        sheetIsPresenting = nil
                    }
            }
        }
        .sheet(isPresented: Binding(sheet: $sheetIsPresenting), content: {
            switch sheetIsPresenting {
            case .modifyItem(let item):
                ModifyItemView(item) { updatedItem in
                    self.item = updatedItem
                    
                    // update viewModel.dueNow's upkeep's emojis...
                    viewModel.dueNow = viewModel.dueNow.map({ task in
                        if task.upkeep.itemID == updatedItem.id {
                            var updatedUpkeep = task.upkeep
                            updatedUpkeep.emoji = updatedItem.emoji
                            return (upkeep: updatedUpkeep, isCompleted: task.isCompleted)
                        } else {
                            return task
                        }
                    })
                }
            case .newUpkeep:
                ModifyUpkeepView(Upkeep(itemID: item.id)) { newUpkeep in
                    self.item.upkeeps.append(newUpkeep)
                    
                    // add newUpkeep to viewModel.dueNow if needed...
                    if newUpkeep.dueDate <= Date.endOfDay {
                        var upkeepWithEmoji = newUpkeep
                        upkeepWithEmoji.emoji = item.emoji
                        viewModel.dueNow.append((upkeep: upkeepWithEmoji, isCompleted: false))
                    }
                }
            case .modifyUpkeep(let upkeep):
                ModifyUpkeepView(upkeep) { updatedUpkeep in
                    self.item.upkeeps[upkeepIndex] = updatedUpkeep
                    
                    var upkeepWithEmoji = updatedUpkeep
                    upkeepWithEmoji.emoji = item.emoji
                    
                    // edit viewModel.dueNow's matching upkeep...
                    if let i = viewModel.dueNow.firstIndex(where: { $0.upkeep.id == upkeepWithEmoji.id }) {
                        // replace old upkeep with updatedUpkeep...
                        if upkeepWithEmoji.dueDate <= Date.endOfDay {
                            viewModel.dueNow[i] = (upkeep: upkeepWithEmoji, isCompleted: false)
                        } else {
                            // remove upkeep if it is not due anymore...
                            viewModel.dueNow.remove(at: i)
                        }
                    } else {
                        // add updatedUpkeep to viewModel.dueNow if needed...
                        if upkeepWithEmoji.dueDate <= Date.endOfDay {
                            viewModel.dueNow.append((upkeep: upkeepWithEmoji, isCompleted: false))
                        }
                    }
                }
            default:
                VStack {
                    Text("Error")
                    Button("Return", action: { sheetIsPresenting = nil })
                }
            }
        })
    }
}



#Preview {
    @State var viewModel = MainViewModel(collection: Item.list, selectedItemID: Item.exShoe.id)
    return ContentView(viewModel: viewModel)
}

extension ItemDetailView {
    struct EmptyView: View {
        let newUpkeep: () -> Void
        
        var body: some View {
            VStack(spacing: 40) {
                Image("washing_dishes")
                    .resizable()
                    .scaledToFit()
                Button("Add Upkeep +", action: newUpkeep)
                    .foregroundStyle(.greenDark)
                Spacer()
            }
        }
    }
}
