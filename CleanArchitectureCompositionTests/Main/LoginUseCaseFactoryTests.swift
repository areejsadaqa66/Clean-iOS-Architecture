//
//  LoginUseCaseFactoryTests.swift
//  CleanArchitectureCompositionTests
//
//  Created by areej sadaqa on 11/04/2026.
//

import XCTest
@testable import CleanArchitectureComposition

final class LoginUseCaseFactoryTests: XCTestCase {

    func test_createdUseCase_hasComposedOutputs() {
        let sut = LoginUseCaseFactory()
        let useCase = sut.makeUseCase()
        let composer = useCase.output as? LoginUseCaseOutputComposer
        XCTAssertNotNil(composer)
        XCTAssertEqual(composer?.outputs.count, 3)
        XCTAssertEqual(composer?.outputs.filter({ $0 is LoginPresenter}).count, 1)
        XCTAssertEqual(composer?.count(ofType: CrashlyticsLoginTracker.self), 1)
        XCTAssertEqual(composer?.count(ofType: FirebaseAnalyticsLoginTracker.self), 1)
    //    XCTAssertTrue(useCase.output is LoginUseCaseOutputComposer)
    }

}

private extension LoginUseCaseOutputComposer {
    func count<T>(ofType: T.Type) -> Int {
        return outputs.filter{$0 is T}.count
    }
}
