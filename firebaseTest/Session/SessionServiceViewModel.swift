//
//  SessionServiceViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 28/03/2023.
//

import Foundation
import Combine

enum UpdateSessionState {
    case successful
    case failed (error:Error)
    case na //not available
}


final class SessionServiceViewModelImp: ObservableObject{
    
    @Published var hasError: Bool = false
    @Published var state: UpdateSessionState = .na
    @Published var details: SessionUserModel
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: SessionServiceImp
    
    init(service: SessionServiceImp, details: SessionUserModel) {
        self.details = details
        self.service = service
        setupErrorSubscriptions()
    }
    
//    func updateFirstname() {
//        service.updateFirstname(with: details)
//            .sink { res in
//                //based on the result if it completes or get an error
//                switch res {
//                    //if error
//                case .failure(let error):
//                    self.state = .failed(error: error)
//                default: break
//                    
//                }
//            } receiveValue: { [weak self] in
//                self?.state = .successful
//            }
//            .store(in: &subscriptions)
//    }
}

private extension SessionServiceViewModelImp{
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

