//
//  MainViewControllerTest.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import XCTest
@testable import RxSwift_Template_Dev

class MainViewControllerTest: XCTestCase {
    private var viewController: MainViewController!

       override func setUp() {
           super.setUp()
           viewController = MainViewController.instantiate()
       }

       func test_ibOutlets() {
           _ = viewController.view
           XCTAssertNotNil(viewController.tableView)
       }
}
