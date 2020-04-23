//
//  APIInput.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Alamofire

class APIInput: APIInputBase {  // swiftlint:disable:this final_class
    override init(urlString: String,
                  parameters: [String: Any]?,
                  requestType: HTTPMethod,
                  requireAccessToken: Bool) {
        super.init(urlString: urlString,
                   parameters: parameters,
                   requestType: requestType,
                   requireAccessToken: requireAccessToken)
        self.headers = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json"
        ]
        self.user = nil
        self.password = nil
    }
}
