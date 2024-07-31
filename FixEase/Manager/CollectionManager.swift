//
//  CollectionManager.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/30/24.
//

import Foundation

class CollectionManager: NSObject, ObservableObject {
    @Published var collection: [Item]
    @Published var selectedItem: (value: Item, index: Int)?
    @Published var selectedUpkeep: (value: Upkeep, index: Int)?
    @Published var selectedNote: (value: String, index: Int?)?
    @Published var modifyItem: Item?
    @Published var modifyUpkeep: Upkeep?
    
    init(collection: [Item], selectedItem: (value: Item, index: Int)? = nil, selectedUpkeep: (value: Upkeep, index: Int)? = nil, selectedNote: (value: String, index: Int)? = nil, modifyItem: Item? = nil, modifyUpkeep: Upkeep? = nil) {
        self.collection = collection
        self.selectedItem = selectedItem
        self.selectedUpkeep = selectedUpkeep
        self.selectedNote = selectedNote
        self.modifyItem = modifyItem
        self.modifyUpkeep = modifyUpkeep
    }
    
    func dismiss() {
        self.modifyItem = nil
        self.modifyUpkeep = nil
        self.selectedNote = nil
    }
    
    func newItemSheet() {
        self.modifyItem = Item()
    }
    
    func newUpkeepSheet() {
        self.modifyUpkeep = Upkeep()
    }
    
    func newNoteSheet() {
        self.selectedNote = (value: "", index: nil)
    }
    
    func modifyItemSheet(_ item: Item) {
        self.modifyItem = item
    }
    
    func modifyUpkeepSheet(_ upkeep: Upkeep) {
        self.modifyUpkeep = upkeep
    }
    
    func modifyNoteSheet(_ note: String, atIndex index: Int) {
        self.selectedNote = (value: note, index: index)
    }
    
    func update(item: Item) {
        print(object: self, function: .updateItem)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        self.collection[itemIndex] = item
        dismiss()
        printSuccess()
    }
    
    func update(upkeep: Upkeep) {
        print(object: self, function: .updateUpkeep)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        guard let upkeepIndex = selectedUpkeep?.index else {
            printFailure(.noUpkeepSelected)
            return
        }
        self.collection[itemIndex].upkeeps[upkeepIndex] = upkeep
        dismiss()
        printSuccess()
    }
    
    func update(note: String) {
        print(object: self, function: .updateNote)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        guard let upkeepIndex = selectedUpkeep?.index else {
            printFailure(.noUpkeepSelected)
            return
        }
        guard let noteIndex = selectedNote?.index else {
            printFailure(.noNoteSelected)
            return
        }
        self.collection[itemIndex].upkeeps[upkeepIndex].notes[noteIndex] = note
        dismiss()
        printSuccess()
    }
    
    func add(item: Item) {
        print(object: self, function: .addItem)
        collection.append(item)
        dismiss()
        printSuccess()
    }
    
    func add(upkeep: Upkeep) {
        print(object: self, function: .addUpkeep)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        collection[itemIndex].upkeeps.append(upkeep)
        dismiss()
        printSuccess()
    }
    
    func add(note: String) {
        print(object: self, function: .addNote)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        guard let upkeepIndex = selectedUpkeep?.index else {
            printFailure(.noUpkeepSelected)
            return
        }
        collection[itemIndex].upkeeps[upkeepIndex].notes.append(note)
        dismiss()
        printSuccess()
    }
    
    func select(item: Item) {
        print(object: self, function: .selectItem)
        guard let index = collection.firstIndex(where: {$0.id == item.id}) else {
            printFailure(.itemNotInCollection)
            return
        }
        self.selectedItem = (value: item, index: index)
        if !collection[index].upkeeps.isEmpty {
            self.select(upkeepAtIndex: 0)
        }
        printSuccess()
    }
    
    func select(upkeepAtIndex index: Int) {
        print(object: self, function: .selectUpkeep)
        guard let itemIndex = selectedItem?.index else {
            printFailure(.noItemSelected)
            return
        }
        self.selectedUpkeep = (value: collection[itemIndex].upkeeps[index], index: index)
        printSuccess()
    }
}

#if DEBUG
extension CollectionManager {
    static var preview = CollectionManager(collection: Item.list)
}
#endif
