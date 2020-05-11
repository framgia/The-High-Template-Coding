//
//  MainUseCase.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol MainUseCaseType {
    func getRepoList(page: Int) -> Observable<ResponseData<[Repo]>>
}

struct MainUseCase: MainUseCaseType {
    let repoRepo: RepoRepositoryType
    
    func getRepoList(page: Int) -> Observable<ResponseData<[Repo]>> {
        return repoRepo.getRepoList(page: page, perPage: 10, useCache: page == 1)
    }
}
