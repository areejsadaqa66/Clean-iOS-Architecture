//
//  CrashlyticsLoginTracker.swift
//  CleanArchitectureComposition
//
//  Created by areej sadaqa on 11/04/2026.
//

import Foundation

final class CrashlyticsLoginTracker: LoginUseCaseOutput {
    func loginSuccess() {
        //send login event to crashlytics
    }
    
    func loginFailed() {
        //send error to crashlytics 
    }
}
