//
//  Untitled.swift
//  CleanArchitectureComposition
//
//  Created by areej sadaqa on 11/04/2026.
//

import Foundation

final class LoginUseCaseFactory {
    func makeUseCase() -> LoginUseCase {
        return LoginUseCase(output: LoginUseCaseOutputComposer([
            LoginPresenter(),
            CrashlyticsLoginTracker(),
            FirebaseAnalyticsLoginTracker()
        ]))
    }
}
