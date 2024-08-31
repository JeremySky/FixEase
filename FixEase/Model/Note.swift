//
//  Note.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/31/24.
//

import Foundation

struct Note: Hashable, Identifiable, Codable {
    var id: UUID
    var string: String
    var isEmpty: Bool { self.string.isEmpty }
    
    init(id: UUID = UUID(), _ string: String) {
        self.id = id
        self.string = string
    }
    
    init() {
        self.init("")
    }
}

extension Note {
    static var listRocketShip1: [Note] = [
        Note("Use S+ tier only."),
        Note("Never top off.")
    ]
    static var listRocketShip2: [Note] = [
        Note("ONLY USE WINDEX"),
        Note("Wash inside and outside.")
    ]
    static var listRocketShip3: [Note] = [
        Note("Rotate clockwise")
    ]
    
    
    static var listGarden1: [Note] = [
        Note("Water East to West")
    ]
    
    
    static var listCoffeeMaker1: [Note] = [
        Note("If molding, light whole thing of fire.")
    ]
}
