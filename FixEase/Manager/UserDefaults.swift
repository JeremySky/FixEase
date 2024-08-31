//
//  UserDefaults.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/28/24.
//

import Foundation

class UserDefaultsHelper {
    static let shared = UserDefaultsHelper()
    private init() {}
    
    let defaults = UserDefaults.standard
    
    let userKey = "User"
    
    func saveUser(_ user: User) {
        if let encodedUser = try? JSONEncoder().encode(user) {
            defaults.setValue(encodedUser, forKey: userKey)
        }
    }
    
    func getUser() -> User? {
        if let savedUserData = defaults.data(forKey: userKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: savedUserData) {
            return savedUser
        }
        return nil
    }
}
