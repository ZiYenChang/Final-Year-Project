//
//  RegisterTest.swift
//  fypUnitTests
//
//  Created by Zi Yen Chang on 26/04/2023.
//
import XCTest
import Combine
@testable import Seed

final class RegisterTest: XCTestCase {
    
    var viewModel: RegisterViewModelImp!
    var mockService: MockRegisterService!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
        mockService = MockRegisterService()
        viewModel = RegisterViewModelImp(service: mockService)
        cancellables = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        mockService = nil
        viewModel = nil
        cancellables = nil
    }

    func testRegisterSuccessWithDetails() {
        // Given
        let expectedUserDetails = RegisterDetailsModel(email: "test@example.com", password: "password", firstName: "John", courseName: "Math")
        mockService.mockRegisterResult = .success(())
        
        // When
        viewModel.userDetails = expectedUserDetails
        viewModel.register()
        
        // Then
        XCTAssert(mockService.registerCalled)
        XCTAssertEqual(viewModel.state, .successful)
        XCTAssertFalse(viewModel.hasError)
    }
    
    func testRegisterFailureWhenReturnError() {
        // Given
        let expectedUserDetails = RegisterDetailsModel(email: "test@example.com", password: "password", firstName: "John", courseName: "Math")
        let expectedError = NSError(domain: "test", code: 0, userInfo: nil)
        mockService.mockRegisterResult = .failure(expectedError)
        
        // When
        viewModel.userDetails = expectedUserDetails
        viewModel.register()
        
        // Then
        XCTAssert(mockService.registerCalled)
        XCTAssertEqual(viewModel.state, .failed(error: expectedError))
        XCTAssertTrue(viewModel.hasError)
    }
    
    // Mock service class used for testing
    class MockRegisterService: RegisterService {
        
        var registerCalled = false
        var mockRegisterResult: Result<Void, Error> = .success(())
        
        func register(with details: RegisterDetailsModel) -> AnyPublisher<Void, Error> {
            registerCalled = true
            return Just(())
                .setFailureType(to: Error.self)
                .flatMap { _ in
                    Future { promise in
                        promise(self.mockRegisterResult)
                    }
                }
                .eraseToAnyPublisher()
        }
    }
}
