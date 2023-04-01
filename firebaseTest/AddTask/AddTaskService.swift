//
//  AddTaskService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase
import SwiftUI


protocol AddTaskService {
    func addTask(with details: TaskModel, with subtasks: [String]) -> AnyPublisher<Void, Error>
}

final class AddTaskServiceImp: AddTaskService {
    
    func addTask(with details: TaskModel, with subtasks: [String]) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                let user = Auth.auth().currentUser
                if let user = user {
                    var autoID = ""
                    let uid = user.uid
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm E, d MMM y"
                    
                    let values = [
                        "title": details.title,
                        "note": details.note,
                        "status": details.status.rawValue,
                        "deadline": dateFormatter.string(from: details.deadline),
                        "lastUpdate": dateFormatter.string(from: Date()),
                        "uid": uid
                    ] as [String : Any]
                    
                    
                    //use firebase database function to update user with values
                    Database.database()
                        .reference()
                        .child("tasks")
                        .childByAutoId()
                        .setValue(values){ error, ref in
                            autoID = ref.key ?? "no task id"
                            if let err = error{
                                promise(.failure (err))
                                print("Failed due to error:", err)
                            }else{
                                promise(.success(()))
                                print("Task added")
                                print(autoID)
                                
                                for subtask in subtasks {
                                    let subtask = [
                                        "title": subtask,
                                        "completed": "false",
                                        "lastUpdate": dateFormatter.string(from: Date()),
                                        "taskid": autoID,
                                        "uid": uid,
                                        "completeDate":""
                                    ] as [String : Any]

                                    Database.database()
                                        .reference()
                                        .child("subtasks")
                                        .childByAutoId()
                                        .setValue(subtask){ error, ref in
                                            if let err = error{
                                                promise(.failure (err))
                                                print("Failed due to error:", err)
                                            }else{
                                                promise(.success(()))
                                                print("Subtask added")
                                            }
                                        }
                                }
                            }
                        }
                    
                    
                }
                
            }
        }
        .receive(on: RunLoop.current)
        .eraseToAnyPublisher()
    }
}
