//
//  User.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/28/24.
//

import Foundation

struct User: Codable {
    var id: UUID
    var name: String
    
    init(id: UUID = UUID(), name: String) {
        self.id = id
        self.name = name
    }
}

extension User {
    static var test = User(name: "John Doe")
}
