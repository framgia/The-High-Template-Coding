//
//  APIConfig.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import Foundation

struct APIConfig {
    static let baseUrl = "https://gateway.marvel.com/v1/public/"
    static let publicKey = "7eaf61246f45854686a3e35d43d4e179"
    static let privateKey = "b94e362dba96805a687b8b58578e73cbf342177e"
    
    //The header fields
    enum HttpHeaderField: String {
        case authentication = "Authorization"
        case contentType = "Content-Type"
        case acceptType = "Accept"
        case acceptEncoding = "Accept-Encoding"
    }
    
    //The content type (JSON)
    enum ContentType: String {
        case json = "application/json"
    }
    
}
