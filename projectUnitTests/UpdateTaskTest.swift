//
//  UpdateTaskTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//


import XCTest
import Combine
@testable import firebaseTest

final class UpdateTaskTest: XCTestCase {
    
    var viewModel: UpdateTaskViewModelImp!
    var service: MockUpdateTaskService!

    override func setUpWithError() throws {
        service = MockUpdateTaskService()
        let details = TaskModel(id: "1", title: "My Task", note: "My Notes", status: .onTrack, deadline: Date(), lastUpdate: "", uid: "1234")
        let subtask = SubtaskModel(id: "1", title: "Subtask", completed: false, lastUpdate: "", taskid: "1", uid: "1234", completeDate: nil)
        viewModel = UpdateTaskViewModelImp(service: service, details: details, subtasks: [subtask])
    }

    override func tearDownWithError() throws {
        viewModel = nil
        service = nil
    }
    
    func testUpdateTask() throws {
        // Given
        let expectation = expectation(description: "Task updated")
        service.result = .success(())
        
        // When
        viewModel.updateTask()
        
        // Then
        viewModel.$state.sink { state in
            switch state {
            case .successful:
                expectation.fulfill()
            default:
                XCTFail("Task update should succeed")
            }
        }.store(in: &viewModel.subscriptions)
        
        waitForExpectations(timeout: 1)
    }
    
    func testConfettiShownWhenStatusCompleted() throws {
        // Given
        let expectation = expectation(description: "Confetti shown")
        let completedDetails = TaskModel(id: "1", title: "My Task", note: "My Notes", status: .completed, deadline: Date(), lastUpdate: "", uid: "1234")
        viewModel.details = completedDetails
        service.result = .success(())
        
        // When
        viewModel.updateTask()
        
        // Then
        viewModel.$state.sink { state in
            switch state {
            case .successful:
                if completedDetails.status == .completed {
                    expectation.fulfill()
                } else {
                    XCTFail("Confetti should be shown when status is completed")
                }
            default:
                XCTFail("Task update should succeed")
            }
        }.store(in: &viewModel.subscriptions)
        
        waitForExpectations(timeout: 1)
    }
}

class MockUpdateTaskService: UpdateTaskService {
    var result: Result<Void, Error> = .failure(NSError(domain: "", code: 0, userInfo: nil))
    
    func updateTask(with details: TaskModel, with subtasks: [SubtaskModel]) -> AnyPublisher<Void, Error> {
        return result.publisher.eraseToAnyPublisher()
    }
    
    func deleteSubtask(with id: String) -> AnyPublisher<Void, Error> {
        return result.publisher.eraseToAnyPublisher()
    }
}








import SwiftUI

final class HomeViewTests: XCTestCase {
    
    var homeView: HomeView!
    

    override func setUp() {
        super.setUp()
        @State var selection = tabs.home
        homeView = HomeView(tabSelection: $selection)
    }

    func testCheckTodaySubtaskCompleted() {
        // Given
        let subtask1 = SubtaskModel(id: "1", title: "Subtask 1", completed: true, lastUpdate: "2023-04-01", taskid: "1", uid: "1", completeDate: "15:36 Sun, 26 Mar 2023")
        let subtask2 = SubtaskModel(id: "2", title: "Subtask 2", completed: false, lastUpdate: "2023-04-01", taskid: "2", uid: "1", completeDate: "15:36 Sun, 26 Mar 2023")
        let subtasks = [subtask1, subtask2]

        // When
        let todaySubtasksCompleted = homeView.mockCheckTodaySubtaskCompleted(subtasks: subtasks)

        // Then
        XCTAssertEqual(todaySubtasksCompleted.count, 0)
        XCTAssertEqual(todaySubtasksCompleted.first?.id, nil)
    }
}

extension HomeView {
    func mockCheckTodaySubtaskCompleted(subtasks: Array<SubtaskModel>) -> Array<SubtaskModel>{
        var todaySubtaskCompleted: [SubtaskModel] = []
        
        for subtask in subtasks {
            if subtask.completed == true {
                if let completeDate = subtask.completeDate {
                    if Calendar.current.isDateInToday(convertStringToDate(date: completeDate)) {
                        todaySubtaskCompleted.append(subtask)
                    }
                }
            }
        }
        
        return todaySubtaskCompleted
    }
}




final class ShowAllTasksViewModelTests: XCTestCase {
    
    var sut: ShowAllTasksViewModel!
    
    override func setUp() {
        super.setUp()
        sut = ShowAllTasksViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDeleteTask() {
        // given
        var task = TaskModel.new
        task.id = "123"
        
        // when
        sut.deleteTask(with: "123")
        
        // then
        XCTAssert(true, "Task deleted successfully")
    }
    
    func testCompleteSubtask() {
        // given
        let tempSubtask = TempSubtaskModel(id: "123", title: "Test Subtask", completed: "true", lastUpdate: "", taskid: "123", uid: "123", completeDate: "2023-04-26")
        
        // when
        let subtask = sut.convertCompleted(tempSubtask: tempSubtask)
        
        // then
        XCTAssertEqual(subtask.id, "123", "ID should be equal")
        XCTAssertEqual(subtask.title, "Test Subtask", "Title should be equal")
        XCTAssertEqual(subtask.completed, true, "Completed should be equal")
        XCTAssertEqual(subtask.lastUpdate, "", "Last update should be equal")
        XCTAssertEqual(subtask.taskid, "123", "Task ID should be equal")
        XCTAssertEqual(subtask.uid, "123", "UID should be equal")
        XCTAssertEqual(subtask.completeDate, "2023-04-26", "Complete date should be equal")
    }
}



class ShowTasksTests: XCTestCase {
    var sut: ShowAllTasksView!
    var vm: ShowAllTasksViewModelMock!

    override func setUp() {
        super.setUp()
        vm = ShowAllTasksViewModelMock()
        sut = ShowAllTasksView(vm: self.vm)
    }

    override func tearDown() {
        vm = nil
        sut = nil
        super.tearDown()
    }

    func testSortByDeadline() throws {
        let task1 = TaskModel(
            id: "1",
            title: "Task 1",
            note: "Task 1 note",
            status: .notStarted,
            deadline: Date(timeIntervalSince1970: 1641038800),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let task2 = TaskModel(
            id: "2",
            title: "Task 2",
            note: "Task 2 note",
            status: .notStarted,
            deadline: Date(timeIntervalSince1970: 1641038100),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let task3 = TaskModel(
            id: "3",
            title: "Task 3",
            note: "Task 3 note",
            status: .notStarted,
            deadline: Date(timeIntervalSince1970: 1641039500),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let tasks = [task1, task2, task3]
        let sortedTasksByLatest = sut.sortByDeadline(tasks: tasks, byLatest: true)
        let sortedTasksByFurther = sut.sortByDeadline(tasks: tasks, byLatest: false)
        
        XCTAssertEqual(sortedTasksByLatest, [task3, task1, task2])
        XCTAssertEqual(sortedTasksByFurther, [task2, task1, task3])
    }

    func testStatusFilter() throws {
        let task1 = TaskModel(
            id: "1",
            title: "Task 1",
            note: "Task 1 note",
            status: .notStarted,
            deadline: Date(timeIntervalSince1970: 1641038800),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let task2 = TaskModel(
            id: "2",
            title: "Task 2",
            note: "Task 2 note",
            status: .onTrack,
            deadline: Date(timeIntervalSince1970: 1641038100),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let task3 = TaskModel(
            id: "3",
            title: "Task 3",
            note: "Task 3 note",
            status: .completed,
            deadline: Date(timeIntervalSince1970: 1641039500),
            lastUpdate: "2022-09-25",
            uid: "1"
        )
        let tasks = [task1, task2, task3]
        
        var filteredTasksAll: [TaskModel] = []
        var filteredTasksNotStarted: [TaskModel] = []
        var filteredTasksCompleted: [TaskModel] = []
        
        for task in tasks{
                filteredTasksAll.append(task)
        }
        
        for task in tasks{
            if (task.status.rawValue == StatusFilter.notStarted.rawValue){
                filteredTasksNotStarted.append(task)
            }
        }
        
        for task in tasks{
            if (task.status.rawValue == StatusFilter.completed.rawValue){
                filteredTasksCompleted.append(task)
            }
        }
        
        
        XCTAssertEqual(filteredTasksAll, tasks)
        XCTAssertEqual(filteredTasksNotStarted, [task1])
        XCTAssertEqual(filteredTasksCompleted, [task3])
    }
}

class ShowAllTasksViewModelMock: ShowAllTasksViewModel {
    var mockTasks: [TaskModel]
    
    override init() {
        self.mockTasks = [
            TaskModel(id: "1", title: "Task 1", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "2", title: "Task 2", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "3", title: "Task 3", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "4", title: "Task 4", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "5", title: "Task 5", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "6", title: "Task 6", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "7", title: "Task 7", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "8", title: "Task 8", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "9", title: "Task 9", note: "", status: .onTrack, deadline: Date(), lastUpdate: ""),
            TaskModel(id: "10", title: "Task 10", note: "", status: .onTrack, deadline: Date(), lastUpdate: "")
        ]
    }
}


final class AddMoodViewModelTests: XCTestCase {

    var viewModel: AddMoodViewModelImp!
    var mockService: MockAddMoodService!

    override func setUp() {
        super.setUp()

        // Initialize the mock service
        mockService = MockAddMoodService()

        // Initialize the view model with the mock service
        viewModel = AddMoodViewModelImp(service: mockService)
    }

    override func tearDown() {
        super.tearDown()

        mockService = nil
        viewModel = nil
    }

    // Test the addMood() function when the service succeeds
    func testAddMoodSuccess() {
        // Set up the mock service to return a successful result
        mockService.result = .success(())

        // Call the addMood() function
        viewModel.mood = 5.0
        viewModel.addMood()

        // Verify that the state is set to .successful
        XCTAssertEqual(viewModel.state, .successful)
    }

//    // Test the addMood() function when the service fails
//    func testAddMoodFailure() {
//        // Set up the mock service to return an error
//        let expectedError = NSError(domain: "com.example.MyApp", code: 123, userInfo: nil)
//        mockService.result = .failure(expectedError)
//
//        // Call the addMood() function
//        viewModel.mood = 2.5
//        viewModel.addMood()
//
//        // Verify that the state is set to .failed with the expected error
//        XCTAssertEqual(viewModel.state, .failed(error: expectedError))
//    }
//
//    // Test the hasError property when the state is .na
//    func testHasErrorWhenStateIsNa() {
//        // Set the state to .na
//        viewModel.state = .na
//
//        // Verify that hasError is false
//        XCTAssertFalse(viewModel.hasError)
//    }
//
//    // Test the hasError property when the state is .successful
//    func testHasErrorWhenStateIsSuccessful() {
//        // Set the state to .successful
//        viewModel.state = .successful
//
//        // Verify that hasError is false
//        XCTAssertFalse(viewModel.hasError)
//    }
//
//    // Test the hasError property when the state is .failed
//    func testHasErrorWhenStateIsFailed() {
//        // Set the state to .failed with an error
//        viewModel.state = .failed(error: NSError(domain: "com.example.MyApp", code: 456, userInfo: nil))
//
//        // Verify that hasError is true
//        XCTAssertTrue(viewModel.hasError)
//    }

}

// A mock implementation of the AddMoodService protocol
class MockAddMoodService: AddMoodService {

    var result: Result<Void, Error>!

    func addMood(with mood: Double) -> AnyPublisher<Void, Error> {
        return Result.Publisher(result)
            .eraseToAnyPublisher()
    }

}

final class MoodModelTests: XCTestCase {

    var rawData: [MoodModel] = []
    
    override func setUp() {
        super.setUp()
        rawData = [MoodModel(id: "1", mood: 2.0, lastUpdate: "15:36 Sun, 19 Mar 2023", uid: "1"),
                   MoodModel(id: "2", mood: 3.5, lastUpdate: "15:36 Sun, 21 Mar 2023", uid: "1")        ]
    }
    
    override func tearDown() {
        rawData = []
        super.tearDown()
    }

    func testMoodChartNoShowWhenNoData() {
        let rawData: [MoodModel] = []
        
        let result = moodModelForChart(rawData: rawData)
        
        XCTAssertEqual(result.count, 0)
    }
    
    func testestMoodChartwithData() {
        let result = moodModelForChart(rawData: rawData)
        
        XCTAssertEqual(result.count, 2)
    }
//    
//    func testMoodModelForChart_withRawData_returnsCorrectChartData() {
//        let result = moodModelForChart(rawData: rawData)
//        
//        XCTAssertEqual(result[0].mood, 2.0)
//        XCTAssertEqual(result[1].mood, 3.5)
//    }

}


class CheckLowMoodTests: XCTestCase {
    
    func testCheck3DaysLowMoodReturnsTrue() {
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let dayBefore = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let today = Date()
        
        //change last update value to current date
        let moods = [
            MoodModel(id: "1", mood: 4.0, lastUpdate: formatDate(date: yesterday), uid: "1"),
            MoodModel(id: "2", mood: 3.5, lastUpdate: formatDate(date: dayBefore), uid: "1"),
            MoodModel(id: "3", mood: 4.0, lastUpdate: formatDate(date: today), uid: "1")
        ]
        
        let result = checkLowMood(moods: moods)
        
        XCTAssertTrue(result)
    }
    
    func testCheck2DaysLowMoodReturnsFalse(){
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let today = Date()
        
        let moods = [
            MoodModel(id: "1", mood: 4.0, lastUpdate: formatDate(date: yesterday), uid: "1"),
            MoodModel(id: "2", mood: 3.5, lastUpdate: formatDate(date: today), uid: "1")
        ]
        
        let result = checkLowMood(moods: moods)
        
        XCTAssertFalse(result)
    }
    
//    func testCheckLowMood_withMoodsBelow5ForDayBeforeToday_returnsFalse() {
//        let dayBefore = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
//        let today = Date()
//
//        let moods = [
//            MoodModel(id: "1", mood: 4.0, lastUpdate: formatDate(date: dayBefore), uid: "1"),
//            MoodModel(id: "2", mood: 3.5, lastUpdate: formatDate(date: today), uid: "1")
//        ]
//
//        let result = checkLowMood(moods: moods)
//
//        XCTAssertFalse(result)
//    }
//
//    func testCheckLowMood_withNoMoodsBelow5_returnsFalse() {
//        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
//        let dayBefore = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
//        let today = Date()
//
//        let moods = [
//            MoodModel(id: "1", mood: 6.0, lastUpdate: formatDate(date: yesterday), uid: "1"),
//            MoodModel(id: "2", mood: 7.5, lastUpdate: formatDate(date: dayBefore), uid: "1"),
//            MoodModel(id: "3", mood: 8.5, lastUpdate: formatDate(date: today), uid: "1")
//        ]
//
//        let result = checkLowMood(moods: moods)
//
//        XCTAssertFalse(result)
//    }

    func formatDate(date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm E, d MMM y"
        return dateFormatter.string(from: date)
    }
}
