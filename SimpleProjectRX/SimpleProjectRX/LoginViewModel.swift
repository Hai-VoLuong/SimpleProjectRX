//
//  LoginViewModel.swift
//  SimpleProjectRX
//
//  Created by Hai Vo L. on 1/3/18.
//  Copyright © 2018 Hai Vo L. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import MVVM

typealias LoginViewModelParams = (userName: ControlProperty<String>, password: ControlProperty<String>, logintap: Observable<Void>)

final class User {
    var name: String = ""
    private var password: String?

    init(name: String, password: String? = nil) {
        self.name = name
        self.password = password
    }
}

struct Validation {
    static let minimumPasswordLength = 5
    static let minimumUserNameLength = 5
}

final class LoginViewModel: MVVM.ViewModel {

    let validatedUserName: Observable<Bool>
    let validatedPassword: Observable<Bool>
    let loginEnabled: Observable<Bool>
    let loginObservable: Observable<(User, Error?)>

//    viewModel = LoginViewModel(input: (userName: usernameTextFiled.rx.text.orEmpty,
//    password: passwordTextFiled.rx.text.orEmpty,
//    logintap: loginButton.rx.tap.asObservable()))

    init(input: LoginViewModelParams) {

        // kiểm tra use input
        validatedUserName = input.userName
            .map { $0.characters.count >= Validation.minimumUserNameLength }
            .shareReplay(1)
        validatedPassword = input.password
            .map{ $0.characters.count >= Validation.minimumPasswordLength }
            .shareReplay(1)

        // check loginEnabled kích hoạt button login
        loginEnabled = Observable.combineLatest(validatedUserName, validatedPassword, resultSelector: { $0 && $1 })

        // login trả vể user and error
        let userAndPassword = Observable.combineLatest(input.userName, input.password, resultSelector: { ($0, $1) })

        loginObservable = input.logintap
            .withLatestFrom(userAndPassword)
            .flatMapLatest { (user, password) in
                return Observable.create { observable in
                    observable.onNext((User(name: user, password: password) , nil))
                    return Disposables.create()
                }
            }
    }
}
