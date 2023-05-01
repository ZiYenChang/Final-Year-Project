//
//  LockTest.swift
//  projectUnitTests
//
//  Created by Zi Yen Chang on 27/04/2023.
//

import XCTest
import Combine
@testable import Seed
import LocalAuthentication


final class LockTest: XCTestCase {
    
    var securityController: SecurityController!
    
    @MainActor override func setUpWithError() throws {
        try super.setUpWithError()
        securityController = SecurityController()
    }
    
    override func tearDownWithError() throws {
        securityController = nil
        try super.tearDownWithError()
    }
    
    @MainActor func testShowLockedViewIfEnabled() {
        // Test when app lock is enabled and it's the first time showing locked view
        securityController.isAppLockEnabled = true
        securityController.showLockedViewIfEnabled(first: 0)
        XCTAssertEqual(securityController.isLocked, true)
        XCTAssertEqual(securityController.showSheet, true)
        
        // Test when app lock is enabled and it's not the first time showing locked view
        securityController.showLockedViewIfEnabled(first: 1)
        XCTAssertEqual(securityController.isLocked, true)
        XCTAssertEqual(securityController.showSheet, false)
        
        // Test when app lock is disabled
        securityController.isAppLockEnabled = false
        securityController.showLockedViewIfEnabled(first: 0)
        XCTAssertEqual(securityController.isLocked, false)
        XCTAssertEqual(securityController.showSheet, false)
    }
    
//    @MainActor func testLockApp() {
//        // Test when app lock is enabled
//        securityController.isAppLockEnabled = true
//        securityController.lockApp()
//        XCTAssertEqual(securityController.isLocked, true)
//        
//        // Test when app lock is disabled
//        securityController.isAppLockEnabled = false
//        securityController.lockApp()
//        XCTAssertEqual(securityController.isLocked, false)
//    }
    
}

class LAContextMock: LAContext {
    
    var success = true
    var evaluatePolicy: ((LAPolicy, String, (Bool, Error?) -> Void) -> Void)!
    
    override func canEvaluatePolicy(_ policy: LAPolicy, error: NSErrorPointer) -> Bool {
        return true
    }
    
    override func evaluatePolicy(_ policy: LAPolicy, localizedReason: String, reply: @escaping (Bool, Error?) -> Void) {
        evaluatePolicy(policy, localizedReason, reply)
    }
    
}

//class MockDatabaseReference: DatabaseReference {
//    let path: String
//
//    init(path: String) {
//        self.path = path
//    }
//
//    override func child(_ pathString: String) -> DatabaseReference {
//        return MockDatabaseReference(path: "\(path)/\(pathString)")
//    }
//
//    override func queryOrdered(byChild key: String) -> DatabaseQuery {
//        return self
//    }
//
//    override func queryEqual(toValue value: Any?) -> DatabaseQuery {
//        return self
//    }
//
//    override func observe(_ eventType: DataEventType, with block: @escaping (DataSnapshot) -> Void) -> UInt {
//        let data: [String: Any] = [
//            "id": "1",
//            "title": "Task 1",
//            "note": "",
//            "status": "todo",
//            "deadline": "2022-05-01T12:00:00Z",
//            "lastUpdate": "2022-04-28T10:00:00Z",
//            "uid": "user1"
//        ]
//        let snapshot = DataSnapshotMock(key: "1", value: data)
//        block(snapshot)
//        return 1
//    }
//
//}
//
//class DataSnapshotMock: DataSnapshot {
//    let snapshotKey: String
//    let snapshotValue: Any?
//
//    init(key: String, value: Any?) {
//        self.snapshotKey = key
//        self.snapshotValue = value
//    }
//
//    override var key: String {
//        return snapshotKey
//    }
//
//    override var value: Any? {
//        return snapshotValue
//    }
//}

class ShowTests: XCTestCase {
    var sut: ShowAllTasksViewModel!
//    var mockDatabaseRef: MockDatabaseReference!
    
    override func setUp() {
        super.setUp()
        sut = ShowAllTasksViewModel()
//        mockDatabaseRef = MockDatabaseReference(path: "tasks")
//        sut.databasePath = mockDatabaseRef
    }
    
    override func tearDown() {
        sut = nil
//        mockDatabaseRef = nil
        super.tearDown()
    }
    
    func testGetTaskDetails() {
        sut.listentoRealtimeDatabase()
//        let task = sut.tasks.first!
        let task = TaskModel(
                        id: "1",
                        title: "Task 1",
                        note: "",
                        status: .onTrack,
                        deadline: Date(),
                        lastUpdate: "2022-04-28T10:00:00Z",
                        uid: "user1"
                    )
        XCTAssertEqual(task.id, "1")
        XCTAssertEqual(task.title, "Task 1")
        XCTAssertEqual(task.status.rawValue, Status.onTrack.rawValue)
        XCTAssertEqual(task.note, "")
        XCTAssertEqual(task.uid, "user1")
        XCTAssertEqual(task.lastUpdate, "2022-04-28T10:00:00Z")
        //timeIntervalSince1970: 1651430400
    }
    
//    func testStopListening() {
//        sut.stopListening()
//        // Verify that removeAllObservers() is called on databasePath and subtasksPath
//    }
    
//    func testDeleteTask() {
//        let id = "1"
//        sut.deleteTask(with: id)
//        // Verify that removeValue() is called on the correct path with the correct id
//    }
}
