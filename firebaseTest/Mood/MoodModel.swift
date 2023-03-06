//
//  MoodModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 14/02/2023.
//

import Foundation

struct MoodModel: Identifiable, Codable, Equatable {
    var id: String?
    var mood: Double
    var lastUpdate: String
    var uid: String?
}
