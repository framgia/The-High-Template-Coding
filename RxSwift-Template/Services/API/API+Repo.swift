//
//  API+Repo.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import ObjectMapper

extension API {
    func getRepoList(_ input: GetRepoListInput) -> Observable<GetRepoListOutput> {
        return request(input)
    }
}

// MARK: - GetRepoList
extension API {
    final class GetRepoListInput: APIInput {
        init(page: Int, perPage: Int = 10) {
            let params: JSONDictionary = [
                JSONKey.language: "language:swift",
                JSONKey.perPage: perPage,
                JSONKey.page: page
            ]
            super.init(urlString: API.Urls.getRepoList,
                       parameters: params,
                       requestType: .get,
                       requireAccessToken: true)
        }
    }
    
    final class GetRepoListOutput: APIOutput {
        private(set) var repos: [Repo]?
        
        override func mapping(map: Map) {
            super.mapping(map: map)
            repos <- map["items"]
        }
    }
}
