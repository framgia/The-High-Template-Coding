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
        let trigger: Driver<Void>
        let reloadTrigger: Driver<Void>
        let loadMoreTrigger: Driver<Void>
    }
    
    struct Output {
        let data: Driver<[Repo]>
        let error: Driver<Error>
        let isLoading: Driver<Bool>
        let isReloading: Driver<Bool>
        let isLoadingMore: Driver<Bool>
        let isEmpty: Driver<Bool>
    }
    
    func transform(_ input: Input) -> Output {
        let getPageResult = getPage(
            loadTrigger: input.trigger,
            reloadTrigger: input.reloadTrigger,
            loadMoreTrigger: input.loadMoreTrigger,
            getItems: useCase.getRepoList(page:))
        
        let (page, paginationError, isLoading, isReloading, isLoadingMore) = getPageResult.destructured
        
        let repoList = page
            .map { $0.items }
        
        let isEmpty = checkIfDataIsEmpty(trigger: Driver.merge(isLoading, isReloading),
                                         items: repoList)
        
        return Output(data: repoList,
                      error: paginationError,
                      isLoading: isLoading,
                      isReloading: isReloading,
                      isLoadingMore: isLoadingMore,
                      isEmpty: isEmpty)
    }
}
