//
//  MainUseCaseMock.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

@testable import RxSwift_Template_Dev
import RxSwift

final class MainUseCaseMock: MainUseCaseType {
 
    // MARK: - loadMoreRepoList
    
    var getRepoListCalled = false
    
    var getRepoListReturnValue: Observable<ResponseData<[Repo]>> = {
        let items = [
            Repo(id: 2,
                 name: "",
                 fullname: "",
                 urlString: "",
                 starCount: 0,
                 folkCount: 1,
                 owner: Owner(avatarUrl: ""))
        ]
        let page = ResponseData<[Repo]>(items: items)
        return Observable.just(page)
    }()
    
    func getRepoList(page: Int) -> Observable<ResponseData<[Repo]>> {
        getRepoListCalled = true
        return getRepoListReturnValue
    }
}
