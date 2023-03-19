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


final class GetMoodViewModel: ObservableObject {
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
    
    func deleteTask(with id: String, with subtasks: [SubtaskModel] = []){
        print("in deleteTask()")
        Database.database()
            .reference()
            .child("tasks")
            .child(id)
            .removeValue(){ error, ref in
                if let err = error{
                    print("Failed due to error:", err)
                }else{
                    print("Task deleted")
                }
            }
        for subtask in subtasks {
            Database.database()
                .reference()
                .child("subtasks")
                .child(subtask.id!)
                .removeValue(){ error, ref in
                    if let err = error{
                        print("Failed due to error:", err)
                    }else{
                        print("Task deleted")
                    }
                }
        }
        
    }
    
    func updateSubtask(with subtask: SubtaskModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        
        let values = [
            "title": subtask.title,
            "completed": "\(subtask.completed)",
            "lastUpdate": dateFormatter.string(from: Date()),
            "taskid": subtask.taskid!,
            "uid": subtask.uid!
        ] as [String : Any]
        
        print("in updateSubtask")
        Database.database()
            .reference()
            .child("subtasks")
            .child(subtask.id!)
            .updateChildValues(values){ error, ref in
                if let err = error{
                    print("Failed due to error:", err)
                }else{
                    print("Subtask Updated in show")
                }
            }
    }
}
