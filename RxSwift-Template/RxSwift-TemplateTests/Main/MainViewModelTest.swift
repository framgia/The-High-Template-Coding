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
    
    private let loadTrigger = PublishSubject<Int>()
    private let selectRepoTrigger = PublishSubject<IndexPath>()
    
    override func setUp() {
        super.setUp()
        navigator = MainNavigatorMock()
        useCase = MainUseCaseMock()
        viewModel = MainViewModel(navigator: navigator, useCase: useCase)
        
        input = MainViewModel.Input(
            trigger: loadTrigger.asDriverOnErrorJustComplete(),
            selectRepoTrigger: selectRepoTrigger.asDriverOnErrorJustComplete()
        )
        
        output = viewModel.transform(input)
        
        disposeBag = DisposeBag()
        output.data.drive().disposed(by: disposeBag)
        output.selectedRepo.drive().disposed(by: disposeBag)
        output.error.drive().disposed(by: disposeBag)
    }
    
    func test_loadTriggerInvoked_getRepoList() {
        // act
        loadTrigger.onNext((1))
        let repoList = try? output.data.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssertEqual(repoList?.count, 1)
    }
    
    func test_loadTriggerInvoked_getRepoList_failedShowError() {
        // arrange
        useCase.getRepoListReturnValue = Observable.error(TestError())

        // act
        loadTrigger.onNext(1)
        let error = try? output.error.toBlocking(timeout: 1).first()
        
        // assert
        XCTAssert(useCase.getRepoListCalled)
        XCTAssert(error is TestError)
    }
    
    func test_selectRepoTriggerInvoked_toRepoDetail() {
          // act
          loadTrigger.onNext(1)
          selectRepoTrigger.onNext(IndexPath(row: 0, section: 0))

          // assert
          XCTAssert(navigator.toRepoDetailCalled)
      }
}
