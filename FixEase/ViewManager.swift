//
//  ViewManager.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/29/24.
//

import Foundation

enum ViewSelection {
    case main, itemDetail(Item)
}

enum SheetPresenting: Identifiable {
    case modifyItem(Item), modifyUpkeep(Upkeep, UUID)
    
    var id: String {
        switch self {
        case .modifyItem:
            "UpdateItem"
        case .modifyUpkeep:
            "UpdateUpkeep"
        }
    }
}

class ViewManager: ObservableObject {
    @Published var current: ViewSelection
    @Published var sheet: SheetPresenting?
    @Published var modifyNote: String?
    
    init(current: ViewSelection = .main, sheet: SheetPresenting? = nil, modifyNote: String? = nil) {
        self.current = current
        self.sheet = sheet
        self.modifyNote = modifyNote
    }
    
    func dismiss() {
        sheet = nil
        modifyNote = nil
    }
}
