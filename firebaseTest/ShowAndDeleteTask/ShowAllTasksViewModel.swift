//
//  ShowAllTaskService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase
import SwiftUI


final class ShowAllTasksViewModel: ObservableObject {
//    https://medium.com/swift-productions/swiftui-fetch-data-from-firebase-realtime-database-611406d8696c
    //let ref = FIRDatabase.database().referenceFromURL(FIREBASE_URL).child("topics")
//    let query = ref.queryOrderedByChild("published").queryEqualToValue(true)
//    query.observeEventType(.Value, withBlock: { (snapshot) in
//        for childSnapshot in snapshot.children {
//            print(childSnapshot)
//        }
//    })
    @Published var tasks: [TaskModel] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("tasks")
        return ref
    }()
    
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    private var uid:String = ""
    init(){
        let user = Auth.auth().currentUser
        if let user = user {
            uid = user.uid
        }
    }
    
    func listentoRealtimeDatabase() {
        self.tasks = []
        guard let databasePath = databasePath else {
            return
        }
        databasePath
            .queryOrdered(byChild: "uid")
            .queryEqual(toValue: uid)
            .observe(.childAdded) { [weak self] snapshot in
                guard
                    let self = self,
                    var json = snapshot.value as? [String: Any]
                else {
                    return
                }
                json["id"] = snapshot.key
                do {
                    let taskData = try JSONSerialization.data(withJSONObject: json)
                    let task = try self.decoder.decode(TaskModel.self, from: taskData)
                    self.tasks.append(task)
                } catch {
                    print("An error occurred", error)
                }
            }
        print("Called realtime Database")
    }
    

    
    func stopListening() {
        databasePath?.removeAllObservers()
    }
    
    func deleteTask(with id: String){
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
        
    }
}
