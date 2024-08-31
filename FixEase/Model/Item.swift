//
//  Item.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

struct Item: Hashable, Identifiable, Codable {
    var id: UUID
    var name: String
    var description: String
    var emoji: String
    var upkeeps: [Upkeep]
    
    var isEmpty: Bool { self.name.isEmpty }
    
    init(id: UUID = UUID(), name: String = "", description: String = "", emoji: String = "", upkeeps: [Upkeep] = []) {
        self.id = id
        self.name = name
        self.description = description
        self.emoji = emoji
        self.upkeeps = upkeeps
    }
}



extension Item {
    static var rocketShipID = UUID(uuidString: "12345678-1234-1234-1234-1234567890ab")!
    static var gardenID = UUID(uuidString: "22345678-1234-1234-1234-1234567890ab")!
    static var coffeeMakerID = UUID(uuidString: "32345678-1234-1234-1234-1234567890ab")!
    
    static var list: [Item] = [exRocketShip, exGarden, exCoffeeMaker, exHouse, exShoe]
    static var exRocketShip = Item(id: Item.rocketShipID, name: "Rocket Ship", description: "MODEL LMNOP The American Dream", emoji: "🚀", upkeeps: Upkeep.listRocketShip)
    static var exGarden = Item(id: Item.gardenID, name: "Garden", description: "Front Yard", emoji: "🌻", upkeeps: Upkeep.listGarden)
    static var exCoffeeMaker = Item(id: Item.coffeeMakerID, name: "Coffee Maker", description: "Keurig", emoji: "☕️", upkeeps: Upkeep.listCoffeeMaker)
    static var exHouse = Item(name: "House", description: "Chores and such...", emoji: "🏡", upkeeps: [])
    static var exShoe = Item(name: "Shoes", description: "Keep them fresh", emoji: "👟", upkeeps: [])
}
