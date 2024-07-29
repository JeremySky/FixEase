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
    var cycle: Cycle
    var emoji: String?
    var notes: [String]
    
    init(description: String = "", dueDate: Date = Date(), cycle: Cycle = Cycle(rule: .weeks, unit: 1), emoji: String? = nil, notes: [String] = []) {
        self.description = description
        self.dueDate = dueDate
        self.cycle = cycle
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
    static var listRocketShip: [Upkeep] = [
        Upkeep(description: "Add rocket fuel", dueDate: Date(), cycle: Cycle(rule: .years, unit: 2), notes: ["Use S+ tier only.", "Never top off."]),
        Upkeep(description: "Wash windows", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .months, unit: 1), notes: ["ONLY USE WINDEX", "Wash inside and outside."]),
        Upkeep(description: "Rotate boosters", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .months, unit: 6), notes: ["Rotate clockwise"])
    ]
    static var listGarden: [Upkeep] = [
        Upkeep(description: "Water Flowers", dueDate: Date(), cycle: Cycle(rule: .weeks, unit: 1), notes: ["Water East to West"]),
        Upkeep(description: "Add Fertilizer", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .weeks, unit: 2)),
        Upkeep(description: "Check for Bugs", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .days, unit: 2))
    ]
    static var listCoffeeMaker: [Upkeep] = [
        Upkeep(description: "Change Filter", dueDate: Date(), cycle: Cycle(rule: .months, unit: 3), notes: ["If molding, light whole thing of fire."]),
        Upkeep(description: "Run Cleaning Pod", dueDate: Calendar.current.date(byAdding: .day, value: -7, to: Date())!, cycle: Cycle(rule: .months, unit: 3)),
        Upkeep(description: "Clean Tank", dueDate: Calendar.current.date(byAdding: .day, value: 4, to: Date())!, cycle: Cycle(rule: .months, unit: 1))
    ]
}

