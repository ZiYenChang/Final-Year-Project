//
//  AddTaskTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//


import XCTest
import Combine
@testable import firebaseTest

final class AddTaskTest: XCTestCase {
    
    var subscriptions = Set<AnyCancellable>()
    var viewModel: AddTaskViewModelImp!
    var mockService: AddTaskService!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockAddTaskService()
        viewModel = AddTaskViewModelImp(service: mockService)
    }

    func testAddTaskWithDetailsSuccess() {
        // given
        let taskModel = TaskModel(title: "New Task", note: "Test Note", status: .completed, deadline: Date(),  lastUpdate: "")
        let subtasks = ["Subtask 1", "Subtask 2"]
        let expectedState: AddTaskState = .successful
        
        // when
        viewModel.details = taskModel
        viewModel.subtasks = subtasks
        viewModel.addTask()
        
        // then
        let expectation = XCTestExpectation()
        viewModel.$state.sink { state in
            if state == expectedState {
                expectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testAddTaskWithInvalidDetailsFailure() {
        // given
        let taskModel = TaskModel(title: "", note: "", status: .completed, deadline: Date(), lastUpdate: "")
        let subtasks = ["Subtask 1", "Subtask 2"]
        let expectedState: AddTaskState = .failed(error: MockAddTaskServiceError.invalidDetails)
        
        // when
        viewModel.details = taskModel
        viewModel.subtasks = subtasks
        viewModel.addTask()
        
        // then
        let expectation = XCTestExpectation()
        viewModel.$state.sink { state in
            if state == expectedState {
                expectation.fulfill()
            }
        }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 2.0)
    }
}

class MockAddTaskService: AddTaskService {
    var error: Error?
    func addTask(with details: TaskModel, with subtasks: [String]) -> AnyPublisher<Void, Error> {
        if details.title.isEmpty || details.note.isEmpty {
            error = MockAddTaskServiceError.invalidDetails
            return Fail(error: error!).eraseToAnyPublisher()
        } else {
            return Just(()).setFailureType(to: Error.self).eraseToAnyPublisher()
        }
    }
}

enum MockAddTaskServiceError: Error {
    case invalidDetails
}
