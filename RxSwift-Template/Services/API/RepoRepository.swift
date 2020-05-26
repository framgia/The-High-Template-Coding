//
//  RepoRepository.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

protocol RepoRepositoryType {
    func getRepoList(page: Int, perPage: Int, useCache: Bool) -> Observable<ResponseData<[Repo]>>
}

final class RepoRepository: RepoRepositoryType {
    func getRepoList(page: Int, perPage: Int, useCache: Bool) -> Observable<ResponseData<[Repo]>> {
      return APIClient.getRepositories(page: page, perPage: perPage)
    }
}
