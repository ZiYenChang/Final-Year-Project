//
//  LoginService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Combine
import Foundation
import FirebaseAuth

protocol LoginService{
    func login(with details: LoginDetailsModel) -> AnyPublisher<Void, Error>
    //if success, use session service to manage user details changes and screen changes
}

final class LoginServiceImp: LoginService{
    func login(with details: LoginDetailsModel) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                Auth.auth()
                    .signIn(withEmail: details.email,
                                password: details.password, completion: { result, err in
                    if let err = err { //if there is an error with value
                        promise(.failure (err))
                        print("Failed due to error:", err)
                    }else{
                        promise(.success (()))
                        print("Successfully login account with ID: \(result?.user.uid ?? "")")
                        
                    }
                    
                })
                
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
