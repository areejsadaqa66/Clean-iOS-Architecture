//
//  LoginUseCaseOutputComposer.swift
//  CleanArchitectureComposition
//
//  Created by areej sadaqa on 11/04/2026.
//

import Foundation

final class LoginUseCaseOutputComposer: LoginUseCaseOutput {
    
    let outputs: [LoginUseCaseOutput]
    
    init(_ outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    func loginSuccess() {
        outputs.forEach({$0.loginSuccess()})
    }
    
    func loginFailed() {
        outputs.forEach({$0.loginFailed()})
    }
}

//having a composer in our usecase make our LoginUseCase clean it doesnt need to know about this compostition and doesnt need to know about any other external layer

//who's gonna use our composer is the factory 


//we can also have compose generic funcs
func compose<T>(_ outputs: [(T) -> Void]) -> (T) -> Void {
    return { value in
        outputs.forEach { $0(value) }
    }
}
