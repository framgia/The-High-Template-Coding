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
  
    }
    
    struct Output {
       
    }

    func transform(_ input: Input) -> Output {
        return Output()
    }
    
   
}
