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
    
    var getRepoListReturnValue: Observable<PagingInfo<Repo>> = {
        let items = [
            Repo().with { $0.id = 2 }
        ]
        
        let page = PagingInfo<Repo>(page: 2, items: items)
        return Observable.just(page)
    }()
    
    func getRepoList(page: Int) -> Observable<PagingInfo<Repo>> {
        getRepoListCalled = true
        return getRepoListReturnValue
    }
}
