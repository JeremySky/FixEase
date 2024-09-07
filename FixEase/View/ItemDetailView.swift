//
//  ItemDetailView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/18/24.
//

import SwiftUI

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
                    .padding(.horizontal)
                    .background(
                        HStack {
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundStyle(.white)
                            Spacer().frame(width: 5)
                        }
                            .shadow(radius: 10, x: -5, y: 5)
                    )
                }
                .padding()
                .frame(maxWidth: 400)
                
                Spacer().frame(height: 60)
                
                ZStack {
                    if !item.upkeeps.isEmpty {
                        UpkeepDetailView($item.upkeeps[upkeepIndex], $sheetIsPresenting) { viewModel.updateUpkeep(selectedItem: &item, upkeepIndex: upkeepIndex, updatedUpkeep: $0) }
                        UpkeepIndexStepper($upkeepIndex, for: item)
                    } else {
                        EmptyView(newUpkeep: { sheetIsPresenting = .newUpkeep })
                    }
                }
            }
        }
        .overlay {
            if sheetIsPresenting?.type == .newNote || sheetIsPresenting?.type == .modifyNote {
                ModifyNoteView(sheetIsPresenting?.value as! Note?, $sheetIsPresenting) { viewModel.saveNote(selectedItem: &self.item, upkeepIndex: self.upkeepIndex, note: $0) }
            }
        }
        .sheet(isPresented: Binding(sheet: $sheetIsPresenting), content: {
            switch sheetIsPresenting {
            case .modifyItem(let item):
                ModifyItemView(item, deleteAction: { viewModel.deleteItem(item) }) { viewModel.updateItem(selectedItem: &self.item, to: $0) }
            case .newUpkeep:
                ModifyUpkeepView(Upkeep(itemID: item.id)) { viewModel.addUpkeep(selectedItem: &self.item, add: $0) }
            case .modifyUpkeep(let upkeep):
                ModifyUpkeepView(upkeep, deleteAction: {
                    self.upkeepIndex -= 1
                    viewModel.deleteUpkeep(deleting: upkeep, from: &item)
                }) { viewModel.updateUpkeep(selectedItem: &self.item, upkeepIndex: self.upkeepIndex, updatedUpkeep: $0) }
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
    @State var viewModel = MainViewModel(user: User.test, collection: Item.list, selectedItemID: Item.exShoe.id)
    @State var item = Item.exShoe
    @State var itemID: UUID? = Item.exShoe.id
    return ItemDetailView($item, $itemID, viewModel: viewModel)
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
