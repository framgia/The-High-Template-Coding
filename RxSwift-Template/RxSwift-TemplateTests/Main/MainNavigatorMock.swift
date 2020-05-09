//
//  MainNavigatorMock.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

@testable import RxSwift_Template_Dev

final class MainNavigatorMock: MainNavigatorType {

    // MARK: - toRepos
    
    var toReposCalled = false
    
    func toRepos() {
        toReposCalled = true
    }

    // MARK: - toRepoDetail
    
    var toRepoDetailCalled = false
    
    func toRepoDetail(repo: Repo) {
        toRepoDetailCalled = true
    }
    
    // MARK: - toRepoCollection
    
    var toRepoCollectionCalled = false
    
    func toRepoCollection() {
        toRepoCollectionCalled = true
    }
}
