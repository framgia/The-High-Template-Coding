//
//  ResponseData.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation

struct ResponseData<T: Codable>: Codable {
    var items: T?
}
