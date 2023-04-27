//
//  AddTaskViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 18/01/2023.
//

import Foundation
import Combine

enum AddTaskState: Equatable{
    case successful
    case failed(error:Error)
    case na

    static func == (lhs: AddTaskState, rhs: AddTaskState) -> Bool {
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

//protocol AddTaskViewModel {
//    func addTask()
//    var state: AddTaskState{ get }
//    var service: AddTaskService{ get }
//    var details: TaskModel{ get }
//    var hasError: Bool{ get }
//    init(service: AddTaskService)
//}

final class AddTaskViewModelImp: ObservableObject{
    
    @Published var hasError: Bool = false
    @Published var state: AddTaskState = .na
    @Published var details: TaskModel = TaskModel.new
    @Published var subtasks: [String] = []
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: AddTaskService //get value from init
    
    init(service: AddTaskService){
        self.service = service//dependency injection
        setupErrorSubscriptions() // whenever this viewmodel gets initialised, it will listen to the changes in state
    }
    
    
    func addTask(){
        service.addTask(with: details, with: subtasks)
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

