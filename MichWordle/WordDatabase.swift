//
//  WordDatabase.swift
//  MichWordle
//
//  Created by Drew Scheffer on 9/22/22.
//

import Foundation

class WordDatabase {
    private let defaults = UserDefaults.standard
    private let words: [String] = [
        "beyster",
        "union",
        "umich",
        "goblue",
        "ugli",
        "baits"
    ]
    var word: String {
        var wordPointer = defaults.integer(forKey: "wordPointer")
        if wordPointer >= words.count - 1 {
            defaults.set(0, forKey: "wordPointer")
            wordPointer = 0
        }
        return words[wordPointer]
    }
    
    func incrementWordPointer() -> Void {
        let wordPointer = defaults.integer(forKey: "wordPointer")
        if wordPointer >= words.count - 1 {
            defaults.set(0, forKey: "wordPointer")
        } else {
            defaults.set(wordPointer + 1, forKey: "wordPointer")
        }
    }
}
