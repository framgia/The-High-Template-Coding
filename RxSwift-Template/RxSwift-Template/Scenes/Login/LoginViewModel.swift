//
//  LoginViewModel.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

struct LoginViewModel {
    let navigator: LoginNavigatorType
    let useCase: LoginUseCaseType
}

// MARK: - ViewModelType
extension LoginViewModel: ViewModelType {
    struct Input {
        let loginTrigger: Driver<(id: String?, password: String?)>
        
    }
    
    struct Output {
        let didSelectLogin: Driver<Void>
        let error: Driver<Error>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let login = input.loginTrigger.flatMapLatest {
            self.useCase.saveAccount(id: $0, passWord: $1)
                .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        }.do(onNext: { _ in
            self.navigator.toMain()
        })
            .mapToVoid()
        
        return Output(didSelectLogin: login,
                      error: errorTracker.asDriver())
    }
}
