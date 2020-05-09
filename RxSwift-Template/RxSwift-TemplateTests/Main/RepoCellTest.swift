//
//  RepoCellTest.swift
//  RxSwift-TemplateTests
//
//  Created by Nguyen The Trinh on 5/9/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import XCTest
@testable import RxSwift_Template_Dev

final class RepoCellTests: XCTestCase {
    var cell: RepoCell!

    override func setUp() {
        super.setUp()
        cell = RepoCell.loadFromNib()
    }

    func test_ibOutlets() {
        XCTAssertNotNil(cell)
        XCTAssertNotNil(cell.nameLabel)
        XCTAssertNotNil(cell.avatarURLStringImageView)
    }
}
