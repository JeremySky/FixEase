//
//  Upkeep.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

struct Upkeep: Hashable, Identifiable {
    var id: UUID
    var description: String
    var dueDate: Date
    var cycle: Cycle
    var itemID: UUID
    var emoji: String?
    var notes: [Note]
    
    var isEmpty: Bool { self.description.isEmpty }
    
    init(id: UUID = UUID(), description: String = "", dueDate: Date = Date(), cycle: Cycle = Cycle(rule: .weeks, unit: 1), itemID: UUID, emoji: String? = nil, notes: [Note] = []) {
        self.id = id
        self.description = description
        self.dueDate = dueDate
        self.cycle = cycle
        self.itemID = itemID
        self.emoji = emoji
        self.notes = notes
    }
}

extension Upkeep {
    struct Cycle: Hashable {
        var rule: Rule
        var unit: Int
        
        var description: String {
            "\(unit) \(unit == 1 ? rule.singularDescription : rule.pluralDescription)"
        }
        
        enum Rule: CaseIterable, Identifiable {
            case days, weeks, months, years
            
            var id: Self { self }
            
            var singularDescription: String {
                switch self {
                case .days:
                    "Day"
                case .weeks:
                    "Week"
                case .months:
                    "Month"
                case .years:
                    "Year"
                }
            }
            
            var pluralDescription: String {
                switch self {
                case .days:
                    "Days"
                case .weeks:
                    "Weeks"
                case .months:
                    "Months"
                case .years:
                    "Years"
                }
            }
        }
    }
}

extension Upkeep {
    static var rocketShipID = UUID(uuidString: "12345678-1234-1234-1234-1234567890ab")!
    static var gardenID = UUID(uuidString: "22345678-1234-1234-1234-1234567890ab")!
    static var coffeeMakerID = UUID(uuidString: "32345678-1234-1234-1234-1234567890ab")!
    
    static var listRocketShip: [Upkeep] = [
        Upkeep(description: "Add Rocket Fuel", dueDate: Date(), cycle: Cycle(rule: .years, unit: 2), itemID: Upkeep.rocketShipID, notes: Note.listRocketShip1),
        Upkeep(description: "Wash Windows", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .months, unit: 1), itemID: Upkeep.rocketShipID, notes: Note.listRocketShip2),
        Upkeep(description: "Rotate Boosters", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .months, unit: 6), itemID: Upkeep.rocketShipID, notes: Note.listRocketShip3)
    ]
    static var listGarden: [Upkeep] = [
        Upkeep(description: "Water Flowers", dueDate: Date(), cycle: Cycle(rule: .weeks, unit: 1), itemID: 
                Upkeep.gardenID, notes: Note.listGarden1),
        Upkeep(description: "Add Fertilizer", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .weeks, unit: 2), itemID:
                Upkeep.gardenID),
        Upkeep(description: "Check for Bugs", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .days, unit: 2), itemID:
                Upkeep.gardenID)
    ]
    static var listCoffeeMaker: [Upkeep] = [
        Upkeep(description: "Change Filter", dueDate: Date(), cycle: Cycle(rule: .months, unit: 3), itemID: Upkeep.coffeeMakerID, notes: Note.listCoffeeMaker1),
        Upkeep(description: "Run Cleaning Pod", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .months, unit: 3), itemID: Upkeep.coffeeMakerID),
        Upkeep(description: "Clean Tank", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .months, unit: 1), itemID: Upkeep.coffeeMakerID)
    ]
}

