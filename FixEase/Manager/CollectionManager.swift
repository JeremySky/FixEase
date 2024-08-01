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
    @Published var selectedNote: (value: Note, index: Int?)?
    @Published var modifyItem: Item?
    @Published var modifyUpkeep: Upkeep?
    
    init(collection: [Item], selectedItem: (value: Item, index: Int)? = nil, selectedUpkeep: (value: Upkeep, index: Int)? = nil, selectedNote: (value: Note, index: Int)? = nil, modifyItem: Item? = nil, modifyUpkeep: Upkeep? = nil) {
        self.collection = collection
        self.selectedItem = selectedItem
        self.selectedUpkeep = selectedUpkeep
        self.selectedNote = selectedNote
        self.modifyItem = modifyItem
        self.modifyUpkeep = modifyUpkeep
    }
    
    
    //MARK: -- Sheet functions
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
        self.selectedNote = (value: Note(), index: nil)
    }
    
    func modifyItemSheet() {
        let item = self.selectedItem!.value
        self.modifyItem = item
    }
    
    func modifyUpkeepSheet() {
        let upkeep = self.selectedUpkeep!.value
        self.modifyUpkeep = upkeep
    }
    
    func modifyNoteSheet(_ note: Note, atIndex index: Int) {
        self.selectedNote = (value: note, index: index)
    }
    
    
    //MARK: -- submit actions...
    func update(item: Item) {
        let itemIndex = selectedItem!.index
        self.collection[itemIndex] = item
        dismiss()
    }
    
    func update(upkeep: Upkeep) {
        let itemIndex = selectedItem!.index
        let upkeepIndex = selectedUpkeep!.index
        self.collection[itemIndex].upkeeps[upkeepIndex] = upkeep
        dismiss()
    }
    
    func update(note: Note) {
        let itemIndex = selectedItem!.index
        let upkeepIndex = selectedUpkeep!.index
        let noteIndex = selectedNote!.index!
        self.collection[itemIndex].upkeeps[upkeepIndex].notes[noteIndex] = note
        dismiss()
    }
    
    func add(item: Item) {
        self.collection.append(item)
        dismiss()
    }
    
    func add(upkeep: Upkeep) {
        let itemIndex = selectedItem!.index
        self.collection[itemIndex].upkeeps.append(upkeep)
        dismiss()
    }
    
    func add(note: Note) {
        let itemIndex = selectedItem!.index
        let upkeepIndex = selectedUpkeep!.index
        self.collection[itemIndex].upkeeps[upkeepIndex].notes.append(note)
        dismiss()
    }
    
    
    //MARK: -- Select Component...
    func select(item: Item) {
        let index = collection.firstIndex(where: {$0.id == item.id})!
        self.selectedItem = (value: item, index: index)
        if !collection[index].upkeeps.isEmpty {
            self.select(upkeepAtIndex: 0)
        }
    }
    
    func select(upkeepAtIndex index: Int) {
        let itemIndex = selectedItem!.index
        self.selectedUpkeep = (value: collection[itemIndex].upkeeps[index], index: index)
    }
}

#if DEBUG
extension CollectionManager {
    static var preview = CollectionManager(collection: Item.list)
}
#endif
