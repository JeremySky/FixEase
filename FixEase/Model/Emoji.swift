//
//  Emoji.swift
//  FixEase
//
//  Created by Jeremy Manlangit on 7/19/24.
//

import Foundation

enum EmojiSelection: String, CaseIterable {
    case 🐕, 🐩, 🐈, 🐈‍, 🐓, 🦜, 🌵, 🌲, 🌳, 🌴, 🌱, 🪴, 🌻, 🍓, 🍎, 🍌, 🍉, 🍍, 🌽, 🥨, 🎂, 🏀, 🎾, 🎹, 🥁, 🎻, 🚗, 🚙, 🛶, 🏡, 📱, 💻, 💈, 🚽, 🛁, 🚀
}

extension String {
    func onlyEmoji() -> String {
        return self.filter({$0.isEmoji})
    }
}

extension Character {
    var isEmoji: Bool {
        guard let scalar = unicodeScalars.first else { return false }
        return scalar.properties.isEmoji && (scalar.value > 0x238C || unicodeScalars.count > 1)
    }
}
