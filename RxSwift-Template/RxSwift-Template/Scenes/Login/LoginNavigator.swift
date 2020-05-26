//
//  LoginNavigator.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol LoginNavigatorType {
     func toMain()
}

struct LoginNavigator: LoginNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toMain() {
        let mainVC: MainViewController = assembler.resolve(navigationController: navigationController)
        navigationController.pushViewController(mainVC, animated: true)
    }
}
