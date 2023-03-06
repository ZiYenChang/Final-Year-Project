//
//  TaskStatusSelection.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 25/01/2023.
//

import Foundation
import SwiftUI

enum Status: String, CaseIterable, Identifiable, Codable {
    case notStarted
    case onTrack
    case warning
    case postponed
    case completed
    
    var accentColor: Color {
        switch self {
        case .notStarted: return Color(red: 199.0/255.0, green: 199.0/255.0, blue: 204.0/255.0, opacity: 1.0)
        case .onTrack: return .green
        case .warning: return .red
        case .postponed: return .orange
        case .completed: return .blue
        }
    }
    
    var text: String {
        switch self {
        case .notStarted: return "Not Started"
        case .onTrack: return "On Track"
        case .warning: return "Warning"
        case .postponed: return "Postpone"
        case .completed: return "Completed"
        }
    }
    
    var id: String {
        text
    }
}


