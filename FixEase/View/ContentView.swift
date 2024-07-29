//
//  ContentView.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/16/24.
//

import SwiftUI

enum ViewSelection {
    case main, itemDetail(Item)
}

enum SheetPresenting: Identifiable {
    case updateItem(Item), updateUpkeep(Upkeep), newItem, newUpkeep
    
    var id: String {
        switch self {
        case .updateItem:
            "UpdateItem"
        case .updateUpkeep:
            "UpdateUpkeep"
        case .newItem:
            "NewItem"
        case .newUpkeep:
            "NewUpkeep"
        }
    }
}

class ViewManager: ObservableObject {
    @Published var current: ViewSelection
    @Published var sheet: SheetPresenting?
    @Published var modifyNote: String?
    
    init(current: ViewSelection = .main, sheet: SheetPresenting? = nil) {
        self.current = current
        self.sheet = sheet
    }
}

struct ContentView: View {
    @StateObject var viewManager = ViewManager()
    @State var collection: [Item] = Item.list
    
    var body: some View {
        ZStack {
            switch viewManager.current {
            case .main:
                MainView($collection)
            case .itemDetail(let matchingItem):
                ItemDetailView($collection.first(where: { $0.wrappedValue.id == matchingItem.id })!)
            }
            if let modifyNote = viewManager.modifyNote {
                ModifyNoteView(modifyNote) { _ in }
            }
        }
        .background(Background().ignoresSafeArea(.keyboard))
        .environmentObject(viewManager)
        .sheet(item: $viewManager.sheet) { sheet in
            switch sheet {
            case .updateItem(let item):
                ModifyItemView(item) { _ in }
                    .environmentObject(viewManager)
            case .updateUpkeep(let upkeep):
                ModifyUpkeepView(upkeep) {}
                    .environmentObject(viewManager)
            case .newItem:
                ModifyItemView() { _ in }
                    .environmentObject(viewManager)
            case .newUpkeep:
                ModifyUpkeepView() {}
                    .environmentObject(viewManager)
            }
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

