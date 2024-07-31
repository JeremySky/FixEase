//
//  Print&Errors.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/30/24.
//

import Foundation

#if DEBUG
func print(object: NSObject, function: Functions) {
    print("-------------------------------------------------------")
    print("[\(object)] \(function.rawValue)")
}

func printFailure(_ error: CustomErrors) {
    var string: String {
        switch error {
        case .noItemSelected:
            "item not selected"
        case .noUpkeepSelected:
            "upkeep not selected"
        case .itemNotInCollection:
            "item not found in collection"
        case .upkeepNotInItem(let item):
            "upkeep not found in item: \(item.name)"
        case .noNoteSelected:
            "note not selected"
        }
    }
    print(string)
    print("FAIL")
}

func printSuccess() {
    print("SUCCESS\n")
}

enum Functions: String {
    case updateItem, updateUpkeep, addItem, addUpkeep, selectItem, selectUpkeep, updateNote, addNote
    
    var rawValue: String {
        switch self {
        case .updateItem:
            "update(_ item:)"
        case .updateUpkeep:
            "update(_ upkeep:)"
        case .addItem:
            "add(_ item:)"
        case .addUpkeep:
            "add(_ upkeep:)"
        case .selectItem:
            "select(_ item:)"
        case .selectUpkeep:
            "select(_ upkeep:)"
        case .updateNote:
            "update(_ note:)"
        case .addNote:
            "add(_ note:)"
        }
    }
}

enum CustomErrors {
    case noItemSelected, noUpkeepSelected, itemNotInCollection, upkeepNotInItem(Item), noNoteSelected
}
#endif
