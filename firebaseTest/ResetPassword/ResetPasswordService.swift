//
//  ReserPasswordService.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine
import FirebaseAuth

protocol ResetPasswordService {
    func resetPassword(to email: String)-> AnyPublisher<Void, Error>
}

final class ResetPasswordServiceImp: ResetPasswordService{
    func resetPassword(to email: String) -> AnyPublisher<Void, Error> {
        Deferred{
            Future{ promise in
                Auth.auth()
                    .sendPasswordReset(withEmail: email) { err in
                    if let err = err { //if there is an error with value
                        promise(.failure (err))
                        print("Failed password reset due to error:", err)
                    }else{
                        promise(.success (()))
                        print("Successfully send password reset email")
                    }
                }
            }
        }
        .eraseToAnyPublisher()
    }
    
}
