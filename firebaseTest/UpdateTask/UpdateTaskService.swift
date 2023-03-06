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
    func updateTask(with details: TaskModel, with subtasks: [SubtaskModel]) -> AnyPublisher<Void, Error>
    func deleteSubtask(with id: String) -> AnyPublisher<Void, Error>
}

final class UpdateTaskServiceImp: UpdateTaskService {
    
    func updateTask(with details: TaskModel, with subtasks: [SubtaskModel]) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                if let taskid = details.id, let uid = details.uid{
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm E, d MMM y"

                    let values = [
                        "title": details.title,
                        "priority": details.priority,
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
                        .child(taskid)
                        .updateChildValues(values){ error, ref in
                            if let err = error{
                                promise(.failure (err))
                                print("Failed due to error:", err)
                            }else{
                                promise(.success(()))
                                print("Task Updated")
                                
                                for subtask in subtasks {
                                    let subtaskValue = [
                                        "title": subtask.title,
                                        "completed": "\(subtask.completed)",
                                        "lastUpdate": dateFormatter.string(from: Date()),
                                        "taskid": taskid,
                                        "uid": uid
                                    ] as [String : Any]
                                    
                                    if let subtaskid = subtask.id{
                                        Database.database()
                                            .reference()
                                            .child("subtasks")
                                            .child(subtaskid)
                                            .setValue(subtaskValue){ error, ref in
                                                if let err = error{
                                                    promise(.failure (err))
                                                    print("Failed due to error:", err)
                                                }else{
                                                    promise(.success(()))
                                                    print("Subtask updated")
                                                }
                                            }
                                        
                                    }else{
                                        Database.database()
                                            .reference()
                                            .child("subtasks")
                                            .childByAutoId()
                                            .setValue(subtaskValue){ error, ref in
                                                if let err = error{
                                                    promise(.failure (err))
                                                    print("Failed due to error:", err)
                                                }else{
                                                    promise(.success(()))
                                                    print("New subtask updated")
                                                }
                                            }
                                    }// end else

                                    
                                }
                                
                            }// end else
                        }
                    
                }
            }
        }
        .receive(on: RunLoop.current)
        .eraseToAnyPublisher()
    }// end func update task
    
    func deleteSubtask(with id: String)-> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                Database.database()
                    .reference()
                    .child("subtasks")
                    .child(id)
                    .removeValue(){ error, ref in
                        if let err = error{
                            promise(.failure (err))
                            print("Failed due to error:", err)
                        }else{
                            promise(.success(()))
                            print("Task deleted")
                        }
                    }
            }
        }
        .receive(on: RunLoop.current)
        .eraseToAnyPublisher()
        
    }
}

