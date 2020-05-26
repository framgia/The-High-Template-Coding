//
//  LoginAssembler.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol LoginAssembler {
    func resolve(navigationController: UINavigationController) -> LoginViewController
    func resolve(navigationController: UINavigationController) -> LoginViewModel
    func resolve(navigationController: UINavigationController) -> LoginNavigatorType
    func resolve() -> LoginUseCaseType
}

extension LoginAssembler {
    func resolve(navigationController: UINavigationController) -> LoginViewController {
        let vc = LoginViewController.instantiate()
        let vm: LoginViewModel = resolve(navigationController: navigationController)
        vc.bindViewModel(to: vm)
        return vc
    }
    
    func resolve(navigationController: UINavigationController) -> LoginViewModel {
        return LoginViewModel(
            navigator: resolve(navigationController: navigationController),
            useCase: resolve()
        )
    }
}

extension LoginAssembler where Self: DefaultAssembler {
    func resolve(navigationController: UINavigationController) -> LoginNavigatorType {
        return LoginNavigator(assembler: self, navigationController: navigationController)
    }
    
    func resolve() -> LoginUseCaseType {
        return LoginUseCase(repoRepo: resolve())
    }
}
