//
//  Upkeep.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

struct Upkeep: Hashable {
    var description: String
    var dueDate: Date
    var emoji: String?
    var notes: [String]
    
    init(description: String, dueDate: Date, emoji: String? = nil, notes: [String] = []) {
        self.description = description
        self.dueDate = dueDate
        self.emoji = emoji
        self.notes = notes
    }
}

extension Upkeep {
    static var listRocketShip: [Upkeep] = [
        Upkeep(description: "Add rocket fuel", dueDate: Date(), notes: ["Use S+ tier only.", "Never top off."]),
        Upkeep(description: "Wash windows", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, notes: ["ONLY USE WINDEX", "Wash inside and outside."]),
        Upkeep(description: "Rotate boosters", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, notes: ["Rotate clockwise"])
    ]
    static var listGarden: [Upkeep] = [
        Upkeep(description: "Water Flowers", dueDate: Date(), notes: ["Water East to West"]),
        Upkeep(description: "Add Fertilizer", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!),
        Upkeep(description: "Check for Bugs", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
    static var listCoffeeMaker: [Upkeep] = [
        Upkeep(description: "Change Filter", dueDate: Date(), notes: ["If molding, light whole thing of fire."]),
        Upkeep(description: "Run Cleaning Pod", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!),
        Upkeep(description: "Clean Tank", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!)
    ]
}
