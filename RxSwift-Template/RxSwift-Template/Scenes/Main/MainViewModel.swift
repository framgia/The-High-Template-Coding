//
//  MainViewModel.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

struct MainViewModel {
    let navigator: MainNavigatorType
    let useCase: MainUseCaseType
}

// MARK: - ViewModelType
extension MainViewModel: ViewModelType {
    struct Input {
        let trigger: Driver<Int>
        let selectRepoTrigger: Driver<Repo>
    }
    
    struct Output {
        let data: Driver<[Repo]>
        let isLoading: Driver<Bool>
        let error: Driver<Error>
        let selectedRepo: Driver<Void>
    }
    
    func transform(_ input: Input) -> Output {
        let errorTracker = ErrorTracker()
        let activityIndicator = ActivityIndicator()
        let isLoading = activityIndicator.asDriver()
        
        let repoList = input.trigger.flatMap {
            self.useCase.getRepoList(page:$0)
                .trackError(errorTracker)
                .trackActivity(activityIndicator)
                .asDriverOnErrorJustComplete()
        }.compactMap {$0.items}
        
        let selectedRepo = input.selectRepoTrigger.map {
            self.navigator.toRepoDetail(repo: $0)
        }
        
        
        return Output(data: repoList,
                      isLoading: isLoading,
                      error: errorTracker.asDriver(),
                      selectedRepo: selectedRepo)
    }
}
