//
//  Dice.swift
//  DiceRoller-UIKit
//
//  Created by Begüm Arıcı on 12.07.2025.
//

import Foundation

struct Dice {
    static func roll() -> Int {
        return Int.random(in: 1...6)
    }
}
