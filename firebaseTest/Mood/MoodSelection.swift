//
//  MoodSelection.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 21/02/2023.
//

import Foundation
import SwiftUI

enum MoodEmoji: String, CaseIterable, Codable {
    case zero
    case one
    case two
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    
    var emoji: String {
        switch self {
        case .zero: return "😭"
        case .one:return "😩"
        case .two:return "😣"
        case .three:return "😔"
        case .four:return "🙁"
        case .five:return "😶"
        case .six:return "🙂"
        case .seven:return "😊"
        case .eight:return "😀"
        case .nine:return "😁"
        case .ten:return "🤩"
        }
    }
    var value: Int {
        switch self {
        case .zero: return 0
        case .one:return 1
        case .two:return 2
        case .three:return 3
        case .four:return 4
        case .five:return 5
        case .six:return 6
        case .seven:return 7
        case .eight:return 8
        case .nine:return 9
        case .ten:return 10
        }
    }
    
    
}
