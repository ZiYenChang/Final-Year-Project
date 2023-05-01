//
//  LoginTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//

import XCTest
import Combine
@testable import firebaseTest

final class LoginTest: XCTestCase {
        
    var sut: LoginViewModelImp!
    var mockService: MockLoginService!
    var cancellables: Set<AnyCancellable>!
    
    override func setUp() {
        super.setUp()
        mockService = MockLoginService()
        sut = LoginViewModelImp(service: mockService)
        cancellables = Set<AnyCancellable>()
    }
    
    override func tearDown() {
        cancellables = nil
        mockService = nil
        sut = nil
        super.tearDown()
    }
    
    func testLoginWithValidCredentialsSetStateToSuccessful() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
        let expectedState: LoginState = .successful
        
        // when
        mockService.loginResult = .success(())
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertEqual(sut.details, expectedDetails)
        XCTAssertEqual(sut.state, expectedState)
    }
    
    func testLoginWithInvalidCredentialsSetStateToFail() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
        let expectedState: LoginState = .failed(error: expectedError)
        
        // when
        mockService.loginResult = .failure(expectedError)
        sut.details = expectedDetails
        sut.login()
        
        
        // then
        XCTAssertEqual(sut.state, expectedState)
        XCTAssertEqual(sut.details, expectedDetails)
        switch sut.state {
        case .failed(let error):
            XCTAssertEqual(error as NSError, expectedError)
        default:
            XCTFail("State should be failed")
        }
    }
    
    func testLoginWithValidCredentialsCallsLoginMethodOnService() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
        mockService.loginResult = .success(())
        
        // when
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertTrue(mockService.loginCalled)
        XCTAssertEqual(mockService.loginDetails, expectedDetails)
    }
    
    func testLoginWithEmailMissingSetStateFailed(){
        // given
        let expectedDetails = LoginDetailsModel(email: "", password: "password123")
        let expectedError = NSError(domain: "test", code: 456, userInfo: nil)
        let expectedState: LoginState = .failed(error: expectedError)
        
        // when
        mockService.loginResult = .failure(expectedError)
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertEqual(sut.state, expectedState)
        XCTAssertEqual(sut.details, expectedDetails)
        switch sut.state {
        case .failed(let error):
            XCTAssertEqual(error as NSError, expectedError)
        default:
            XCTFail("State should be failed")
        }
    }
    
    func testLoginWithPasswordMissingSetStateFailed() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "")
        let expectedError = NSError(domain: "test", code: 456, userInfo: nil)
        let expectedState: LoginState = .failed(error: expectedError)
        
        // when
        mockService.loginResult = .failure(expectedError)
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertEqual(sut.state, expectedState)
        XCTAssertEqual(sut.details, expectedDetails)
        switch sut.state {
        case .failed(let error):
            XCTAssertEqual(error as NSError, expectedError)
        default:
            XCTFail("State should be failed")
        }
    }
    
}

class MockLoginService: LoginService {
    var loginCalled = false
    var loginDetails: LoginDetailsModel?
    var loginResult: Result<Void, Error> = .success(())
    
    
    func login(with details: LoginDetailsModel) -> AnyPublisher<Void, Error> {
        Future { promise in
            self.loginCalled = true
            self.loginDetails = details
            promise(self.loginResult)
        }.eraseToAnyPublisher()
    }
}


final class ResetPasswordTests: XCTestCase {
    
    var viewModel: ResetPasswordViewModelImp!
    var mockService: MockResetPasswordService!
    var subscriptions = Set<AnyCancellable>()
    
    override func setUp() {
        super.setUp()
        mockService = MockResetPasswordService()
        viewModel = ResetPasswordViewModelImp(service: mockService)
    }
    
    override func tearDown() {
        mockService = nil
        viewModel = nil
        subscriptions.removeAll()
        super.tearDown()
    }
    
    func testResetPasswordSuccess() {
        // Given
        let email = "test@example.com"
        mockService.result = .success(())
        viewModel.email = email
        
        // When
        viewModel.resetPassword()
        
        // Then
        XCTAssertEqual(mockService.email, email)
        XCTAssertNil(mockService.error)
    }
    
    func testResetPasswordFailure() {
        // Given
        let email = "test@example.com"
        let error = NSError(domain: "test", code: 0, userInfo: nil)
        mockService.result = .failure(error)
        viewModel.email = email
        
        // When
        viewModel.resetPassword()
        
        // Then
        XCTAssertEqual(mockService.email, email)
        XCTAssertNotNil(mockService.error)
    }
}

class MockResetPasswordService: ResetPasswordService {
    var email: String?
    var result: Result<Void, Error>!
    
    var error: Error? {
        switch result {
        case .failure(let error):
            return error
        default:
            return nil
        }
    }
    
    func resetPassword(to email: String) -> AnyPublisher<Void, Error> {
        self.email = email
        return result.publisher.eraseToAnyPublisher()
    }
}
