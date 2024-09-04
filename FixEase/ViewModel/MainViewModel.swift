//
//  Collection.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/7/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var user: User?
    @Published var collection: [Item]
    @Published var selectedItemID: UUID?
    @Published var dueNow: [(upkeep: Upkeep, isCompleted: Bool)]
    
    init(user: User? = nil, collection: [Item], selectedItemID: UUID? = nil, dueNow: [(upkeep: Upkeep, isCompleted: Bool)] = []) {
        self.user = user
        self.collection = collection
        self.selectedItemID = selectedItemID
        self.dueNow = dueNow
        
        getUser()
        getCollection()
    }
    
    func changeName(to newName: String) {
        if var updatedUser = self.user {
            updatedUser.name = newName
            UserDefaultsHelper.shared.saveUser(updatedUser)
            self.user!.name = newName
        } else {
            print("Error user is not logged in")
        }
    }
    
    func deleteAccount() {
        FileManagerHelper.shared.deleteItems()
        UserDefaultsHelper.shared.deleteUser()
        self.user = nil
        self.collection = []
        self.selectedItemID = nil
        self.dueNow = []
    }
    
    func saveNote(selectedItem item: inout Item, upkeepIndex: Int, note: Note) {
        if let i = item.upkeeps[upkeepIndex].notes.firstIndex(where: { $0.id == note.id }) {
            item.upkeeps[upkeepIndex].notes[i] = note
        } else {
            item.upkeeps[upkeepIndex].notes.append(note)
        }
        
        FileManagerHelper.shared.saveItem(item)
    }
    
    func updateUpkeep(selectedItem item: inout Item, upkeepIndex: Int, updatedUpkeep: Upkeep) {
        item.upkeeps[upkeepIndex] = updatedUpkeep
        
        var upkeepWithEmoji = updatedUpkeep
        upkeepWithEmoji.emoji = item.emoji
        
        // edit viewModel.dueNow's matching upkeep...
        if let i = self.dueNow.firstIndex(where: { $0.upkeep.id == upkeepWithEmoji.id }) {
            // replace old upkeep with updatedUpkeep...
            if upkeepWithEmoji.dueDate <= Date.endOfDay {
                self.dueNow[i] = (upkeep: upkeepWithEmoji, isCompleted: false)
            } else {
                // remove upkeep if it is not due anymore...
                self.dueNow.remove(at: i)
            }
        } else {
            // add updatedUpkeep to viewModel.dueNow if needed...
            if upkeepWithEmoji.dueDate <= Date.endOfDay {
                self.dueNow.append((upkeep: upkeepWithEmoji, isCompleted: false))
            }
        }
        
        
        
        FileManagerHelper.shared.saveItem(item)
    }
    
    func addUpkeep(selectedItem item: inout Item, add newUpkeep: Upkeep) {
        item.upkeeps.append(newUpkeep)
        
        // add newUpkeep to viewModel.dueNow if needed...
        if newUpkeep.dueDate <= Date.endOfDay {
            var upkeepWithEmoji = newUpkeep
            upkeepWithEmoji.emoji = item.emoji
            self.dueNow.append((upkeep: upkeepWithEmoji, isCompleted: false))
        }
        
        FileManagerHelper.shared.saveItem(item)
    }
    
    func updateItem(selectedItem item: inout Item, to updatedItem: Item) {
        item = updatedItem
        // update viewModel.dueNow's upkeep's emojis...
        self.dueNow = self.dueNow.map({ task in
            if task.upkeep.itemID == updatedItem.id {
                var updatedUpkeep = task.upkeep
                updatedUpkeep.emoji = updatedItem.emoji
                return (upkeep: updatedUpkeep, isCompleted: task.isCompleted)
            } else {
                return task
            }
        })
        
        // persist to FileManager - replacing data at path matching items id
        FileManagerHelper.shared.saveItem(updatedItem)
    }
    
    private func getCollection() {
        let items = FileManagerHelper.shared.fetchItems()
        guard let items else { /* ERROR */ return }
        self.collection = items
    }
    
    func addItem(_ item: Item) {
        FileManagerHelper.shared.saveItem(item)
        self.collection.append(item)
    }
    
    func createUser(_ name: String) {
        let newUser = User(name: name)
        self.user = newUser
        UserDefaultsHelper.shared.saveUser(newUser)
    }
    
    private func getUser() {
        self.user = UserDefaultsHelper.shared.getUser()
    }
    
    func refreshDueDate(upkeep: Upkeep) {
        let cycle = upkeep.cycle
        let rule = cycle.rule
        let unit = cycle.unit
        var components = DateComponents()
        
        switch rule {
        case .days:
            components.day = unit
        case .weeks:
            components.day = (unit * 7)
        case .months:
            components.month = unit
        case .years:
            components.year = unit
        }
        
        let refreshedDate = Calendar.current.date(byAdding: components, to: Date())!
        let i = self.collection.firstIndex(where: { $0.id == upkeep.itemID })!
        let j = self.collection[i].upkeeps.firstIndex(where: { $0.id == upkeep.id })!
        
        self.collection[i].upkeeps[j].dueDate = refreshedDate
        
        var updatedItem = self.collection[i]
        updatedItem.upkeeps[j].dueDate = refreshedDate
        
        FileManagerHelper.shared.saveItem(updatedItem)
    }
    
    func moveUpkeepToBottomOfList(id: UUID) {
        if let i = self.dueNow.firstIndex(where: { $0.upkeep.id == id }) {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                let element = self.dueNow.remove(at: i)
                self.dueNow.append(element)
            }
        }
    }
    
    func getUpkeepsDueNow() {
        func setEmoji(from item: Item, to upkeep: Upkeep) -> Upkeep {
            var updatedUpkeep = upkeep
            updatedUpkeep.emoji = item.emoji
            return updatedUpkeep
        }
        
        var list = [Upkeep]()
        for item in collection {
            for upkeep in item.upkeeps {
                if upkeep.dueDate <= Date.endOfDay {
                    list.append(setEmoji(from: item, to: upkeep))
                }
            }
        }
    
        self.dueNow = list.sorted(by: { $0.emoji! < $1.emoji! }).map({(upkeep: $0, isCompleted: false)})
    }
    
    func getItemIndex() -> Int? {
        self.collection.firstIndex(where: {$0.id == self.selectedItemID})
    }
}
