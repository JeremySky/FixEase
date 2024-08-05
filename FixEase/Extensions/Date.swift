//
//  Date.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 8/5/24.
//

import SwiftUI

extension Date {
    static var endOfDay: Date {
        var components = Calendar.current.dateComponents([.year, .month, .day], from: Date())
        components.hour = 23
        components.minute = 59
        components.second = 59
        
        return Calendar.current.date(from: components)!
    }
}
