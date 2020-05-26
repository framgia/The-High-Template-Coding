//
//  MainNavigator.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol MainNavigatorType {
     func toRepoDetail(repo: Repo)
}

struct MainNavigator: MainNavigatorType {
    unowned let assembler: Assembler
    unowned let navigationController: UINavigationController
    
    func toRepoDetail(repo: Repo) {
        print(repo.name)
    }
}
