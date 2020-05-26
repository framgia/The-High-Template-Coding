//
//  Driver+.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 5/12/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

extension SharedSequenceConvertibleType {
    
    public func mapToVoid() -> SharedSequence<SharingStrategy, Void> {
        return map { _ in }
    }
    
    public func mapToOptional() -> SharedSequence<SharingStrategy, Element?> {
        return map { value -> Element? in value }
    }
    
    public func unwrap<T>() -> SharedSequence<SharingStrategy, T> where Element == T? {
        return flatMap { SharedSequence.from(optional: $0) }
    }
}
