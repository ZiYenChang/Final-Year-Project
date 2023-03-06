//
//  AddMoodViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 14/02/2023.
//

import Foundation
import Combine

enum AddMoodState {
    case successful
    case failed (error:Error)
    case na //not available
}

protocol AddMoodViewModel {
    func addMood()
    var state: AddMoodState{ get }
    var service: AddMoodService{ get }
    var mood: Double{ get }
    var hasError: Bool{ get }
    init(service: AddMoodService)
}

final class AddMoodViewModelImp: ObservableObject, AddMoodViewModel{
    
    @Published var hasError: Bool = false
    @Published var state: AddMoodState = .na
    @Published var mood: Double = 0.0
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: AddMoodService //get value from init
    
    init(service: AddMoodService){
        self.service = service//dependency injection
        setupErrorSubscriptions() // whenever this viewmodel gets initialised, it will listen to the changes in state
    }
    
    
    func addMood(){
        service.addMood(with: mood)
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
            .store(in: &subscriptions)

    }
    
}

private extension AddMoodViewModelImp{
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

