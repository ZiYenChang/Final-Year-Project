//
//  UpdateTaskService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//


import Foundation
import Combine
import Firebase
import FirebaseDatabase


protocol UpdateTaskService {
    func updateTask(with details: TaskModel) -> AnyPublisher<Void, Error>
}

final class UpdateTaskServiceImp: UpdateTaskService {
    
    func updateTask(with details: TaskModel) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                if let taskid = details.id, let uid = details.uid{
//                    let dateFormatter = DateFormatter()
//                    dateFormatter.dateFormat = "HH:mm E, d MMM y"

                    let values = [
                        "title": details.title,
                        "priority": details.priority,
                        "note": details.note,
//                        "lastUpdate": dateFormatter.string(from: Date()),
                        "uid": uid
                    ] as [String : Any]
                    
                    //use firebase database function to update user with values
                    Database.database()
                        .reference()
                        .child("tasks")
                        .child(taskid)
                        .updateChildValues(values){ error, ref in
                            if let err = error{
                                promise(.failure (err))
                                print("Failed due to error:", err)
                            }else{
                                promise(.success(()))
                                print("Task Updated")
                            }
                        }
                    
                }
            }
        }
        .receive(on: RunLoop.current)
        .eraseToAnyPublisher()
    }
}

