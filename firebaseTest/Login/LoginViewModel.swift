//
//  LoginViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine


enum LoginState: Equatable{
    case successful
    case failed(error:Error)
    case na
    
    static func == (lhs: LoginState, rhs: LoginState) -> Bool {
        switch (lhs, rhs) {
        case (.successful, .successful):
            return true
            
        case (let .failed(lhsError), let .failed(rhsError)):
            return (lhsError).localizedDescription == (rhsError).localizedDescription

        case (.na, .na):
            return true

        default:
            return false
        }
    }
    
}

protocol LoginViewModel{
    func login()
    var state: LoginState{ get }
    var service: LoginService{ get }
    var details: LoginDetailsModel{ get }
    var hasError: Bool{ get }
    init(service: LoginService)
}

final class LoginViewModelImp: ObservableObject, LoginViewModel{
    
    @Published var hasError: Bool = false
    @Published var state: LoginState = .na
    @Published var details: LoginDetailsModel = LoginDetailsModel.new // use the extension that includes empty details
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: LoginService //get value from init
    
    init(service: LoginService){
        self.service = service//dependency injection
        setupErrorSubscriptions() // whenever this viewmodel gets initialised, it will listen to the changes in state
    }
    
    
    func login(){
        service.login(with: details)
            .sink { res in
                
                //based on the result if it completes or get an error
                switch res {
                    //if error
                case .failure(let error):
                    self.state = .failed(error: error)
                default: break
                    
                }
            } receiveValue: { [weak self] in
                self?.state = .successful
            }
            .store(in: &subscriptions) //to keep it alive

    }
    
}

private extension LoginViewModelImp{
    //observe the state changes, depending on the state change, set if an error has occured the bool
    func setupErrorSubscriptions(){
        $state
            .map{ state -> Bool in
                switch state{
                case .successful, .na:
                    return false
                case .failed:
                    return true
                }
            }
            .assign(to: &$hasError)//assign the mapped value to hasError
    }
}


