//
//  LoginError.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/26/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

enum LoginError: Error {
    case empty
}

extension LoginError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .empty:
            return "Can't be empty"
        }
    }
}
