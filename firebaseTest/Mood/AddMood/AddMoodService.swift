//
//  AddMoodService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 14/02/2023.
//

import Foundation
import Combine
import Firebase
import FirebaseDatabase


protocol AddMoodService {
    func addMood(with mood: Double) -> AnyPublisher<Void, Error>
}

final class AddMoodServiceImp: AddMoodService {
    
    func addMood(with mood: Double) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                let user = Auth.auth().currentUser
                if let user = user {
                    let uid = user.uid
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "HH:mm E, d MMM y"

                    let values = [
                        "mood": mood,
                        "lastUpdate": dateFormatter.string(from: Date()),
                        "uid": uid
                    ] as [String : Any]
                    
                    //use firebase database function to update user with values
                    Database.database()
                        .reference()
                        .child("mood")
                        .childByAutoId()
                        .setValue(values){ error, ref in
                            if let err = error{
                                promise(.failure (err))
                                print("Failed adding mood due to error:", err)
                            }else{
                                promise(.success(()))
                                print("mood added")
                            }
                        }
                    
                }
            }
        }
        .receive(on: RunLoop.current)
        .eraseToAnyPublisher()
    }
}


