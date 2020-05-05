//
//  String+Ext.swift
//  RxSwift-Template
//
//  Created by Dung Khuat on 5/5/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation
extension String {
    var localized: String {
        return NSLocalizedString(self, comment: "")
    }
}
