//
//  Binding.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 9/4/24.
//

import SwiftUI

extension Binding where Value == Bool {
    init(sheet: Binding<Sheet?>) {
        self.init {
            switch sheet.wrappedValue?.type {
            case nil, .modifyNote, .newNote:
                return false
            default:
                return true
            }
        } set: { newValue in
            if !newValue { sheet.wrappedValue = nil }
        }

    }
}
