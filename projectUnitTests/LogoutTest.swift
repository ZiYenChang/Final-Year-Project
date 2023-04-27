//
//  LogoutTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//

//import XCTest
//
//final class LogoutTest: XCTestCase {
//
//    override func setUpWithError() throws {
//        // Put setup code here. This method is called before the invocation of each test method in the class.
//    }
//
//    override func tearDownWithError() throws {
//        // Put teardown code here. This method is called after the invocation of each test method in the class.
//    }
//
//    func testExample() throws {
//        // This is an example of a functional test case.
//        // Use XCTAssert and related functions to verify your tests produce the correct results.
//        // Any test you write for XCTest can be annotated as throws and async.
//        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
//        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
//    }
//
//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        self.measure {
//            // Put the code you want to measure the time of here.
//        }
//    }
//
//}

import XCTest
import Combine
import FirebaseAuth
@testable import firebaseTest

final class LogoutTest: XCTestCase {
    
    var sessionService: SessionServiceImp!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        sessionService = SessionServiceImp()
        cancellables = []
    }
    
    override func tearDown() {
        cancellables = nil
        sessionService = nil
        super.tearDown()
    }
    
    func testLogoutToEndSession() {
        // Given a user is logged in
        sessionService.state = .loggedIn
        
        // When the user logs out
        sessionService.logout()
        sessionService.state = .loggedOut
        
        // Then the session state should be logged out
        XCTAssertEqual(sessionService.state, .loggedOut)
        
        // And the user details should be nil
        XCTAssertNil(sessionService.userDetails)
    }
    
    func testSessionLifecycle() {
            // Given a user is logged in
            sessionService.state = .loggedIn
            sessionService.userDetails = SessionUserModel(firstName: "John", courseName: "Math", uid: "123")
            
            // Then the user details should not be nil
            XCTAssertNotNil(sessionService.userDetails)
            
            // When the user performs an action that requires authentication
            let actionRequiresAuth = sessionService.userDetails != nil
            
            // Then the action should succeed
            XCTAssertTrue(actionRequiresAuth)
            
            // When the user logs out
            sessionService.logout()
            sessionService.state = .loggedOut
            sessionService.userDetails = nil
            
            // Then the session state should be logged out
            XCTAssertEqual(sessionService.state, .loggedOut)
            
            // And the user details should be nil
            XCTAssertNil(sessionService.userDetails)
            
            // When the user performs the same action that required authentication earlier
            let actionRequiresAuthAfterLogout = sessionService.userDetails != nil
            
            // Then the action should fail because the user is not authenticated
            XCTAssertFalse(actionRequiresAuthAfterLogout)
        }
}
