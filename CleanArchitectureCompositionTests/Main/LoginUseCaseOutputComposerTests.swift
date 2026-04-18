//
//  LoginUseCaseOutputComposerTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by areej sadaqa on 11/04/2026.
//

import XCTest
@testable import CleanArchitectureComposition

final class LoginUseCaseOutputComposerTests: XCTestCase {

  func test_composingZeoOutputs_doessNotCrash() {
      let sut = LoginUseCaseOutputComposer([] )
      sut.loginSuccess()
      sut.loginFailed()
    }

    func test_composingOneOutput_delegatesSuceededMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginSuccess()
        
        XCTAssertEqual(output1.loginSuccessCallCount, 1)
        XCTAssertEqual(output1.loginFailedCallCount, 0)
    }
    
    func test_composingOneOutput_delegatesFailedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginFailed()
        
        XCTAssertEqual(output1.loginSuccessCallCount, 0)
        XCTAssertEqual(output1.loginFailedCallCount, 1)
    }
    
    func test_composingMultipleOutput_delegatesSuceededMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginSuccess()
        
        XCTAssertEqual(output1.loginSuccessCallCount, 1)
        XCTAssertEqual(output1.loginFailedCallCount, 0)
        
        XCTAssertEqual(output2.loginSuccessCallCount, 1)
        XCTAssertEqual(output2.loginFailedCallCount, 0)
    }
    
    func test_composingMultipleOutput_delegatesFailedMessage() {
        let output1 = LoginUseCaseOutputSpy()
        let output2 = LoginUseCaseOutputSpy()
        let sut = LoginUseCaseOutputComposer([output1])
        sut.loginFailed()
        
        XCTAssertEqual(output1.loginSuccessCallCount, 0)
        XCTAssertEqual(output1.loginFailedCallCount, 1)
        
        XCTAssertEqual(output2.loginSuccessCallCount, 0)
        XCTAssertEqual(output2.loginFailedCallCount, 1)
    }
    
    private class LoginUseCaseOutputSpy:  LoginUseCaseOutput {
        var loginSuccessCallCount = 0
        var loginFailedCallCount = 0
        
        func loginSuccess() {
            loginSuccessCallCount += 1
        }
        
        func loginFailed() {
            loginFailedCallCount += 1
        }
    }
}
