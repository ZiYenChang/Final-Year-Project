//
//  GetMoodViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 21/02/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase
import SwiftUI


class GetMoodViewModel: ObservableObject {
//    https://medium.com/swift-productions/swiftui-fetch-data-from-firebase-realtime-database-611406d8696c

    @Published var moods: [MoodModel] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("mood")
        return ref
    }()
    
    
    private let decoder = JSONDecoder()
    
    private var uid:String = ""
    init(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
    }
    
    
    func moodlistenDatabase() {
        self.moods = []
        
        guard let databasePath = databasePath else {
            return
        }
        databasePath
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: uid)
            .observe(.childAdded) { [weak self] snapshot  in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                    
                else {
                    print("Nothing")
                    return
                }
                
                json["id"] = snapshot.key
                do {
                    let moodData = try JSONSerialization.data(withJSONObject: json)
                    let mood = try self.decoder.decode(MoodModel.self, from: moodData)
                    self.moods.append(mood)
                } catch {
                    print("An error occurred", error)
                }
            }
        
        print("Called mood Database")
    }

    
    func moodStopListening() {
        databasePath?.removeAllObservers()
    }
    
   
    
}
