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

struct TempTaskModel: Identifiable, Codable {
    var id: String?
    var title: String
    var note: String
    var status: Status
    var deadline: String
    var lastUpdate: String
    var uid: String?
    
}

struct TempSubtaskModel: Identifiable, Codable {
    var id: String?
    var title: String
    var completed: String
    var lastUpdate: String
    var taskid: String?
    var uid: String?
    var completeDate: String?
}


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
    @Published var subtasks: [SubtaskModel] = []
    
    private lazy var databasePath: DatabaseReference? = {
        let ref = Database.database().reference().child("tasks")
        return ref
    }()
    
    private lazy var subtasksPath: DatabaseReference? = {
        let ref = Database.database().reference().child("subtasks")
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
    
    func convertDeadline(tempTask: TempTaskModel)-> TaskModel{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        let newDeadline = dateFormatter.date(from: tempTask.deadline)
        var newTask = TaskModel.new
        newTask.title = tempTask.title
        newTask.status = tempTask.status
        newTask.deadline = newDeadline ?? Date()
        newTask.note = tempTask.note
        newTask.lastUpdate = tempTask.lastUpdate
        newTask.id = tempTask.id
        newTask.uid = tempTask.uid
        
        return newTask
    }
    
    func convertCompleted(tempSubtask: TempSubtaskModel)-> SubtaskModel{
        var newTask = SubtaskModel.new
        newTask.title = tempSubtask.title
        newTask.lastUpdate = tempSubtask.lastUpdate
        newTask.id = tempSubtask.id
        newTask.uid = tempSubtask.uid
        newTask.taskid = tempSubtask.taskid
        newTask.completeDate = tempSubtask.completeDate
        
        if(tempSubtask.completed == "false"){
            newTask.completed = false
        }else if (tempSubtask.completed == "true"){
            newTask.completed = true
        }
        
        return newTask
    }
    
    func listentoRealtimeDatabase() {
        self.tasks = []
        self.subtasks = []
        
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
                    let taskData = try JSONSerialization.data(withJSONObject: json)
                    let task = try self.decoder.decode(TempTaskModel.self, from: taskData)
                    self.tasks.append(self.convertDeadline(tempTask: task))
                    print("'eachtask'")
                    print(self.convertDeadline(tempTask: task))
                } catch {
                    print("An error occurred", error)
                }
            }
        
        guard let subtasksPath = subtasksPath else {
            return
        }
        subtasksPath
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
                    let subtaskData = try JSONSerialization.data(withJSONObject: json)
                    let subtask = try self.decoder.decode(TempSubtaskModel.self, from: subtaskData)
                    self.subtasks.append(self.convertCompleted(tempSubtask: subtask))
                } catch {
                    print("An error occurred", error)
                }
            }
        print("Called realtime Database")
    }

    
    func stopListening() {
        databasePath?.removeAllObservers()
        subtasksPath?.removeAllObservers()
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
    
    func completeTask(with task: TaskModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"

        let values = [
            "title": task.title,
            "note": task.note,
            "status": Status.completed.rawValue,
            "deadline": dateFormatter.string(from: task.deadline),
            "lastUpdate": dateFormatter.string(from: Date()),
            "uid": uid
        ] as [String : Any]
        
        //use firebase database function to update user with values
        Database.database()
            .reference()
            .child("tasks")
            .child(task.id!)
            .updateChildValues(values){ error, ref in
                if let err = error{
                    print("Failed due to error:", err)
                }
                else{
                    print("Task Updated as complete")
                }
            }
    }
    
    func updateSubtask(with subtask: SubtaskModel){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        var values = [
            "title": subtask.title,
            "completed": "\(subtask.completed)",
            "lastUpdate": dateFormatter.string(from: Date()),
            "taskid": subtask.taskid!,
            "uid": subtask.uid!,
            "completeDate":""
        ] as [String : Any]
        
        if subtask.completed {
            values = [
                "title": subtask.title,
                "completed": "\(subtask.completed)",
                "lastUpdate": dateFormatter.string(from: Date()),
                "taskid": subtask.taskid!,
                "uid": subtask.uid!,
                "completeDate": dateFormatter.string(from: Date())
            ]
        }
        
        
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
