//
//  RegisterViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine

enum RegisterState {
    case successful
    case failed (error:Error)
    case na //not available
}

protocol RegisterViewModel {
    //function: to handle registration
    func register()
    //property: for injecting and using service
    var service: RegisterService{ get }
    //property: handling state changes within the view model
    var state: RegisterState{ get }
    //property: to bind the user input with view model
    var userDetails: RegisterDetailsModel{ get }
    //initialiser: can actually inject service to view model
    init(service: RegisterService)
    var hasError: Bool{ get }
}

final class RegisterViewModelImp: ObservableObject, RegisterViewModel{
    
    let service: RegisterService //get value from init
    
    @Published var hasError: Bool = false
    
    @Published var state: RegisterState = .na
    
    @Published var userDetails: RegisterDetailsModel = RegisterDetailsModel.new // use the extension that includes empty details
    
    private var subscriptions = Set<AnyCancellable>()
    
    init(service: RegisterService){
        self.service = service
        setupErrorSubscriptions() 
    }
    
    //use the service in this function - listen the value that gets published
    func register(){
        service.register(with: userDetails) //call the register function(from RegisterService) which is a publisher
            .sink { [weak self] res in //get the value from publisher
                
                //based on the result if it completes or get an error
                switch res {
                    //if error
                case .failure(let error):
                    self?.state = .failed(error: error)
                default: break
                    
                }
            } receiveValue: { [weak self] in // if we receive value like success
                self?.state = .successful
            }
            .store(in: &subscriptions) //store in set any cancellable

    }
    
}

private extension RegisterViewModelImp{
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

