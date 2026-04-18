//
//  LoginUseCase.swift
//  CleanArchitectureComposition
//
//  Created by areej sadaqa on 11/04/2026.
//

protocol LoginUseCaseOutput: AnyObject {
    func loginSuccess()
    func loginFailed()
}

class LoginUseCaseWrong {
    //the easiest way to compose trackerts and sadly most use is to concrete all implementation inside use case or the view controller which responsible for logging those events
    //we lose track of dependencies and it's implicit
    //will start to remove them and depend on singletones and so on
    //
    
    let crashlyticsTracker: CrashlyticsLoginTracker
    let firebaseTracker: FirebaseAnalyticsLoginTracker
    let loginPresenter: LoginPresenter
    
    init(crashlyticsTracker: CrashlyticsLoginTracker, firebaseTracker: FirebaseAnalyticsLoginTracker, loginPresenter: LoginPresenter) {
        self.crashlyticsTracker = crashlyticsTracker
        self.firebaseTracker = firebaseTracker
        self.loginPresenter = loginPresenter
    }
    
    func login(name: String, password: String) {
        //
        crashlyticsTracker.loginSuccess()
        firebaseTracker.loginSuccess()
        loginPresenter.loginSuccess()
    }
}

//Solution: to remove dependencies from concrete type would be just to change the types
//buisiness logic has no idea the properits exist and login presenter
//but still lie, because it doesn't able to extend, or remove sth without chngin this class, if we should follow open/close principle we should be able to extend the behaviour without having to change the class, and we're trying to use composition rather than inhertitance here

class LoginUseCaseWrong2 {
    
    let crashlyticsTracker: LoginUseCaseOutput
    let firebaseTracker: LoginUseCaseOutput
    let loginPresenter: LoginUseCaseOutput
    
    init(crashlyticsTracker: LoginUseCaseOutput, firebaseTracker: LoginUseCaseOutput, loginPresenter: LoginUseCaseOutput) {
        self.crashlyticsTracker = crashlyticsTracker
        self.firebaseTracker = firebaseTracker
        self.loginPresenter = loginPresenter
    }
    
    func login(name: String, password: String) {
        //
        crashlyticsTracker.loginSuccess()
        firebaseTracker.loginSuccess()
        loginPresenter.loginSuccess()
    }
}

//and we should make it 'final' class so no way to subclass it, and to make it very flexible I don;t have to change this class is
//but this makes a desgin of my use case wierd because I just want to send a message, dont want to iterate and send the message, it's not single responsibility, so what I can do is
final class LoginUseCaseWrong3 {
    
    let outputs: [LoginUseCaseOutput]
    
    init(outputs: [LoginUseCaseOutput]) {
        self.outputs = outputs
    }
    
    func login(name: String, password: String) {
        //if success
        outputs.forEach({ $0.loginSuccess()})
        //else
        outputs.forEach({ $0.loginFailed()})
    }
}

//just have one output, but how can we logging sending a message to one type but then getting it delegated to all of the ones I want
//regardign to our diagram we're setting a ComposeLoginUseCaseDelegate which responsible for composing all the objects together instead of making the cmposition inside the useCase
//explicitly set this responsibility to Main, because 'Main' is responsible for factoring objects Main is responsible for composing and set it up the application in my object graph way everything is composed so I can have clean code in all my layers
//I never know the compositon layer in buisness logic or presentations layer or UI
final class LoginUseCase {
    
    let output: LoginUseCaseOutput
    
    init(output: LoginUseCaseOutput) {
        self.output = output
    }
    
    func login(name: String, password: String) {
        //if success
       // output.loginSuccess()
        //else
       // output.loginFailed()
    }
}
