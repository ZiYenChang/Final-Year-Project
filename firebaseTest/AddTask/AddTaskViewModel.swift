//
//  AddTaskViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine

enum AddTaskState {
    case successful
    case failed (error:Error)
    case na //not available
}

protocol AddTaskViewModel {
    func addTask()
    var state: AddTaskState{ get }
    var service: AddTaskService{ get }
    var details: TaskModel{ get }
    var hasError: Bool{ get }
    init(service: AddTaskService)
}

final class AddTaskViewModelImp: ObservableObject, AddTaskViewModel{
    
    @Published var hasError: Bool = false
    @Published var state: AddTaskState = .na
    @Published var details: TaskModel = TaskModel.new
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: AddTaskService //get value from init
    
    init(service: AddTaskService){
        self.service = service//dependency injection
        setupErrorSubscriptions() // whenever this viewmodel gets initialised, it will listen to the changes in state
    }
    
    
    func addTask(){
        service.addTask(with: details)
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

private extension AddTaskViewModelImp{
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

