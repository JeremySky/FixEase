//
//  Collection.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/7/24.
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var name: String
    @Published var collection: [Item]
    @Published var selectedItemID: UUID?
    @Published var dueNow: [(upkeep: Upkeep, isCompleted: Bool)]
    
    init(name: String = "", collection: [Item], selectedItemID: UUID? = nil, dueNow: [(upkeep: Upkeep, isCompleted: Bool)] = []) {
        self.name = name
        self.collection = collection
        self.selectedItemID = selectedItemID
        self.dueNow = dueNow
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
