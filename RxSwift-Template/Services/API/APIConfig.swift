//
//  APIConfig.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation

struct APIConfig {
    static var baseUrl: String {
        #if DEV || DEV_BUILD
        return "https://api.github.com"
        #elseif STAGING || STAGING_BUILD
        return "https://api.github.com"
        #else
        return "https://api.github.com"
        #endif
    }
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
        case OS = "os"
        case versionApp = "version"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
    
    struct ValueHeader {
        static let os = "iOS"
        static var version: String? {
            return appVersion()
        }
    }
}
