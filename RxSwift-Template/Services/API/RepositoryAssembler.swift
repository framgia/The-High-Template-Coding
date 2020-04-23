//
//  RepositoryAssembler.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol RepositoriesAssembler {
    func resolve() -> RepoRepositoryType
}

extension RepositoriesAssembler where Self: DefaultAssembler {
    func resolve() -> RepoRepositoryType {
        return RepoRepository()
    }
    
}
