//
//  MainViewModelTest.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking
@testable import RxSwift_Template_Dev

class MainViewModelTest: XCTestCase {
    
    private var viewModel: MainViewModel!
    private var navigator: MainNavigatorMock!
    private var useCase: MainUseCaseMock!
    
    private var input: MainViewModel.Input!
    private var output: MainViewModel.Output!
    
    private var disposeBag: DisposeBag!
    
    private let loadTrigger = PublishSubject<Void>()
    private let reloadTrigger = PublishSubject<Void>()
    private let loadMoreTrigger = PublishSubject<Void>()
    
    override func setUp() {
        super.setUp()
        navigator = MainNavigatorMock()
        useCase = MainUseCaseMock()
        viewModel = MainViewModel(navigator: navigator, useCase: useCase)
        
        input = MainViewModel.Input(
            trigger: loadTrigger.asDriverOnErrorJustComplete(),
            reloadTrigger: reloadTrigger.asDriverOnErrorJustComplete(),
            loadMoreTrigger: loadMoreTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        
        output.error.drive().disposed(by: disposeBag)
        output.isLoading.drive().disposed(by: disposeBag)
        output.isReloading.drive().disposed(by: disposeBag)
        output.isLoadingMore.drive().disposed(by: disposeBag)
        output.data.drive().disposed(by: disposeBag)
        output.isEmpty.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getRepoList() {
        // act
        loadTrigger.onNext(())
        let repoList = try? output.data.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssertEqual(repoList?.count, 1)
    }
    
    func test_loadTriggerInvoked_getRepoList_failedShowError() {
        // arrange
        useCase.getRepoListReturnValue = Observable.error(TestError())

        // act
        loadTrigger.onNext(())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssert(error is TestError)
    }

    func test_reloadTriggerInvoked_getRepoList() {
        // act
        reloadTrigger.onNext(())
        let repoList = try? output.data.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssertEqual(repoList?.count, 1)
    }

    func test_reloadTriggerInvoked_getRepoList_failedShowError() {
        // arrange
        useCase.getRepoListReturnValue = Observable.error(TestError())

        // act
        reloadTrigger.onNext(())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssert(error is TestError)
    }

    func test_reloadTriggerInvoked_notGetRepoListIfStillLoading() {
        // arrange
        useCase.getRepoListReturnValue = Observable.never()

        // act
        loadTrigger.onNext(())
        useCase.getRepoListCalled = false
        reloadTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRepoListCalled)
    }

    func test_reloadTriggerInvoked_notGetRepoListIfStillReloading() {
        // arrange
        useCase.getRepoListReturnValue = Observable.never()

        // act
        reloadTrigger.onNext(())
        useCase.getRepoListCalled = false
        reloadTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRepoListCalled)
    }

    func test_loadMoreTriggerInvoked_loadMoreRepoList() {
        // act
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let repoList = try? output.data.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssertEqual(repoList?.count, 2)
    }

    func test_loadMoreTriggerInvoked_loadMoreRepoList_failedShowError() {
        // arrange
        useCase.getRepoListReturnValue = Observable.error(TestError())

        // act
        loadTrigger.onNext(())
        loadMoreTrigger.onNext(())
        let error = try? output.error.toBlocking(timeout: 1).first()

        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssert(error is TestError)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreRepoListIfStillLoading() {
        // arrange
        useCase.getRepoListReturnValue = Observable.never()

        // act
        loadTrigger.onNext(())
        useCase.getRepoListCalled = false
        loadMoreTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRepoListCalled)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreRepoListIfStillReloading() {
        // arrange
        useCase.getRepoListReturnValue = Observable.never()

        // act
        reloadTrigger.onNext(())
        useCase.getRepoListCalled = false
        loadMoreTrigger.onNext(())
        
        // assert
        XCTAssertFalse(useCase.getRepoListCalled)
    }

    func test_loadMoreTriggerInvoked_notLoadMoreDocumentTypesStillLoadingMore() {
        // arrange
        useCase.getRepoListReturnValue = Observable.never()
        
        // act
        loadMoreTrigger.onNext(())
        useCase.getRepoListCalled = false
        loadMoreTrigger.onNext(())

        // assert
        XCTAssertFalse(useCase.getRepoListCalled)
    }
}
