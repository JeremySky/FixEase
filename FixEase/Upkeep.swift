//
//  Upkeep.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

struct Upkeep {
    var description: String
    var dueDate: Date
    var emoji: String?
    
    init(description: String, dueDate: Date, emoji: String? = nil) {
        self.description = description
        self.dueDate = dueDate
        self.emoji = emoji
    }
}

extension Upkeep {
    static var listRocketShip: [Upkeep] = [
        Upkeep(description: "Add rocket fuel", dueDate: Date()),
        Upkeep(description: "Wash windows", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!),
        Upkeep(description: "Rotate boosters", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
    static var listGarden: [Upkeep] = [
        Upkeep(description: "Water Flowers", dueDate: Date()),
        Upkeep(description: "Add Fertilizer", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!),
        Upkeep(description: "Check for Bugs", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
    static var listCoffeeMaker: [Upkeep] = [
        Upkeep(description: "Change Filter", dueDate: Date()),
        Upkeep(description: "Run Cleaning Pod", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!),
        Upkeep(description: "Clean Tank", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
}
