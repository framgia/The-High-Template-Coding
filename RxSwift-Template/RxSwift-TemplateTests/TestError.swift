//
//  TestError.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import UIKit
import Validator

struct TestError: Error {

}

struct TestValidationError: ValidationError {
    var message: String {
        return "validation error"
    }
}
