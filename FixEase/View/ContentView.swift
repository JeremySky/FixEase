//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewManager = ViewManager()
    @State var collection: [Item] = Item.list
    
    var body: some View {
        ZStack {
            switch viewManager.current {
            case .main:
                MainView($collection)
            case .itemDetail(let item):
                ItemDetailView($collection.first(where: { $0.wrappedValue.id == item.id })!)
            }
            
            // Custom Sheet for ModifyNoteView...
            if let note = viewManager.modifyNote {
                ModifyNoteView(note) { _ in }
            }
        }
        .background(Background().ignoresSafeArea(.keyboard))
        .environmentObject(viewManager)
        .sheet(item: $viewManager.sheet) { sheet in
            ZStack {
                switch sheet {
                case .modifyItem(let item):
                    ModifyItemView(item) { updatedItem in
                        if item.name.isEmpty {
                            collection.append(updatedItem)
                        } else {
                            let index = collection.firstIndex(where: { $0.id == updatedItem.id })!
                            collection[index] = updatedItem
                        }
                        viewManager.dismiss()
                    }
                case .modifyUpkeep(let upkeep, let itemID):
                    ModifyUpkeepView(upkeep) { updatedUpkeep in
                        let itemIndex = collection.firstIndex(where: { $0.id == itemID })!
                        if upkeep.description.isEmpty {
                            collection[itemIndex].upkeeps.append(updatedUpkeep)
                        } else {
                            let upkeepIndex = collection[itemIndex].upkeeps.firstIndex(where: { $0.id == updatedUpkeep.id })!
                            collection[itemIndex].upkeeps[upkeepIndex] = updatedUpkeep
                        }
                        viewManager.dismiss()
                    }
                }
            }
            .environmentObject(viewManager)
        }
    }
}

extension ContentView {
    struct Background: View {
        var body: some View {
            GeometryReader { geometry in
                VStack {
                    Ellipse()
                        .frame(width: 550, height: 350)
                        .foregroundStyle(Gradient(colors: [Color.greenLight, Color.greenDark]))
                        .rotationEffect(.degrees(-7))
                    Spacer()
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
                .offset(y: -geometry.size.height/6.3)
            }
        }
    }
}

#Preview {
    ContentView()
}

