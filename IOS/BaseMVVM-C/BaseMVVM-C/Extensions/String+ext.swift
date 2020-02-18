//
//  String+ext.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        guard let currentLanguages = UserDefaults.standard.string(forKey: "AppleLanguage"), let bundlePath = Bundle.main.path(forResource: currentLanguages, ofType: "lproj"), let bundle = Bundle(path: bundlePath) else {
            return NSLocalizedString(self, comment: "")
        }
        return NSLocalizedString(self, tableName: nil, bundle: bundle, comment: "")
    }
}
