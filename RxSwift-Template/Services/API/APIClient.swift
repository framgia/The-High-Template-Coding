//
//  NetworkingManager+ext.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation

// MARK: - API
struct APIClient {
    // API Create Profile
    static func getRepositories(page: Int, perPage: Int) -> Observable<ResponseData<[Repo]>> {
        return NetworkingManager.request(APIRouter.getRepositories(page, perPage))
    }
}
