//
//  Item.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

struct Item: Hashable {
    var name: String
    var description: String
    var emoji: String
    var upkeeps: [Upkeep]
}


extension Item {
    static var list: [Item] = [exRocketShip, exGarden, exCoffeeMaker, exHouse, exShoe]
    static var exRocketShip = Item(name: "Rocket Ship", description: "MODEL LMNOP The American Dream", emoji: "🚀", upkeeps: Upkeep.listRocketShip)
    static var exGarden = Item(name: "Garden", description: "Front Yard", emoji: "🌻", upkeeps: Upkeep.listGarden)
    static var exCoffeeMaker = Item(name: "Coffee Maker", description: "Keurig", emoji: "☕️", upkeeps: Upkeep.listCoffeeMaker)
    static var exHouse = Item(name: "House", description: "Chores and such...", emoji: "🏡", upkeeps: [])
    static var exShoe = Item(name: "Shoes", description: "Keep them fresh", emoji: "👟", upkeeps: [])
}