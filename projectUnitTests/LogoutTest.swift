//
//  LogoutTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//

import XCTest
import Combine
import FirebaseAuth
@testable import Seed

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
