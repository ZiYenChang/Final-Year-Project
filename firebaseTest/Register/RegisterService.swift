//
//  RegisterService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

//handling user creation

import Combine
import Foundation
import Firebase
import FirebaseDatabase

protocol RegisterService {
    func register(with details: RegisterDetailsModel) -> AnyPublisher<Void, Error> // return a publisher that be subscribed. If successful, do nothing. If failed, drawback the error.
}

//use final so no other class can subclass this class
final class RegisterServiceImp: RegisterService {
    func register(with details: RegisterDetailsModel) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                Auth.auth()
                    .createUser(withEmail: details.email,
                                password: details.password, completion: { result, err in
                    if let err = err {
                        promise(.failure (err))
                        print("Failed due to error:", err)
                    }else{
                        print("Successfully created account with ID: \(result?.user.uid ?? "")")
                        
                        if let uid = result?.user.uid { //from the result, get user id if we can unwrapped it.
                            
                            //create a dictionary for the value that we want to store in firebase
                            //KEY:VALUE, we use the enum here to avoid typo
                            let values = [
                                "firstName": details.firstName,
                                "courseName": details.courseName,
                                "email": details.email
                            ] as [String : Any]
                            
                            //use firebase database function to update user with values
                            Database.database()
                                    .reference()
                                    .child("users")
                                    .child(uid) // child node in users using the user id
                                    .updateChildValues(values){ error, ref in
                                        if let err = error{
                                            promise(.failure (err))
                                        }else{
                                            promise(.success(()))
                                        }
                                    }
                            
                            
                        }else{
                            promise(.failure(NSError(domain: "Invalid User Id", code: 0, userInfo: nil)))
                        }
                    }
                    
                })
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
}
