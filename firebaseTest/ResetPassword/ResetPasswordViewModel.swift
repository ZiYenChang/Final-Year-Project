//
//  ResetPasswordViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine

//no enum because we dont need to listen to the event - once email sent, we do nothing

//protocol ResetPasswordViewModel{
//    func resetPassword()
//    var service: ResetPasswordService{get}
//    var email: String{get}
//    init(service: ResetPasswordService)
//}

final class ResetPasswordViewModelImp: ObservableObject{
    @Published var email: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: ResetPasswordService
    
    init(service: ResetPasswordService) {
        self.service = service
    }
    
    func resetPassword() {
        service.resetPassword(to: email)
            .sink { res in //response from publisher
                switch res{
                case .failure(let err):
                    print("Failed: \(err)")
                default: break
                }
                
            } receiveValue: {
                print("Sent password reset request.")
            }
            .store(in: &subscriptions)

    }
}
