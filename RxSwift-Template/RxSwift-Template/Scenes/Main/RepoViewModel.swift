//
//  RepoViewModel.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

struct RepoViewModel {
    let repo: Repo
    
    var name: String {
        return repo.name
    }
    
    var url: URL? {
        return URL(string: repo.owner.avatarUrl)
    }
}

