//
//  UpdateTaskViewModel.swift
//  firebaseTest
//
//  Created by Zi Yen Chang on 19/01/2023.
//

import Foundation
import Combine

enum UpdateTaskState {
    case successful
    case failed (error:Error)
    case na //not available
}

protocol UpdateTaskViewModel {
    func updateTask()
    func deleteSubtask()
    var state: UpdateTaskState{ get }
    var service: UpdateTaskService{ get }
    var details: TaskModel{ get }
    var hasError: Bool{ get }
    init(service: UpdateTaskService, details: TaskModel, subtasks: [SubtaskModel])
}

final class UpdateTaskViewModelImp: ObservableObject, UpdateTaskViewModel {
    
    @Published var hasError: Bool = false
    @Published var state: UpdateTaskState = .na
    @Published var details: TaskModel
    @Published var subtasks: [SubtaskModel]
    @Published var subID: String = ""
    
    private var subscriptions = Set<AnyCancellable>()
    
    let service: UpdateTaskService
    
    init(service: UpdateTaskService, details: TaskModel, subtasks: [SubtaskModel]) {
        self.details = details
        self.service = service
        self.subtasks = subtasks
        self.subID = subID
        setupErrorSubscriptions()
    }
    
    func updateTask() {
        service.updateTask(with: details, with: subtasks)
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
    func deleteSubtask() {
        service.deleteSubtask(with: subID)
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

private extension UpdateTaskViewModelImp{
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

