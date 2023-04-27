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
    
//    func test_login_with_invalid_credentials_should_set_hasError_to_true() {
//        // given
//        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
//        let expectedError = NSError(domain: "test", code: 123, userInfo: nil)
//        mockService.loginResult = .failure(expectedError)
//
//        // when
//        sut.details = expectedDetails
//        sut.login()
//
//        // then
//        XCTAssertEqual(sut.hasError, true)
//    }
//
//    func test_login_with_empty_credentials_should_set_state_to_failed() {
//        // given
//        let expectedDetails = LoginDetailsModel(email: "", password: "")
//        let expectedError = NSError(domain: "test", code: 456, userInfo: nil)
//        let expectedState: LoginState = .failed(error: expectedError)
//
//        // when
//        mockService.loginResult = .failure(expectedError)
//        sut.details = expectedDetails
//        sut.login()
//
//        // then
//        XCTAssertEqual(sut.state, expectedState)
//        XCTAssertEqual(sut.details, expectedDetails)
//        switch sut.state {
//        case .failed(let error):
//            XCTAssertEqual(error as NSError, expectedError)
//        default:
//            XCTFail("State should be failed")
//        }
//    }
    
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
    
    func test_login_with_valid_credentials_does_not_set_hasError() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
        mockService.loginResult = .success(())
        
        // when
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertEqual(sut.hasError, false)
    }
    
    func test_login_with_valid_credentials_should_not_set_state_to_failed() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
        mockService.loginResult = .success(())
        let notExpectedState: LoginState = .failed(error: NSError(domain: "test", code: 123, userInfo: nil))
        
        // when
        sut.details = expectedDetails
        sut.login()
        
        // then
        XCTAssertNotEqual(sut.state, notExpectedState)
    }
    
    func test_login_with_valid_credentials_and_unexpected_error_should_set_state_to_failed() {
        // given
        let expectedDetails = LoginDetailsModel(email: "test@example.com", password: "password123")
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
