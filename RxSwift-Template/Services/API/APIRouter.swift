//
//  APIRouter.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter: URLRequestConvertible {
    case getRepositories(_ page: Int,_ perPage: Int)
    
    var baseURL: String {
        switch self {
        case .getRepositories:
            return APIConfig.baseUrl
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(APIConfig.ContentType.json.rawValue, forHTTPHeaderField: APIConfig.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(APIConfig.ContentType.json.rawValue, forHTTPHeaderField: APIConfig.HttpHeaderField.contentType.rawValue)
        urlRequest.setValue(APIConfig.ValueHeader.version, forHTTPHeaderField: APIConfig.HttpHeaderField.versionApp.rawValue)
        urlRequest.setValue(APIConfig.ValueHeader.os, forHTTPHeaderField: APIConfig.HttpHeaderField.OS.rawValue)
        
        // timeout
        urlRequest.timeoutInterval = TimeInterval(15)
        
        //Encoding
        let encoding: ParameterEncoding = {
            switch method {
            case .get:
                return URLEncoding.default
            default:
                return JSONEncoding.default
            }
        }()
        
        return try encoding.encode(urlRequest, with: parameters)
    }
    
    // MARK: - HttpMethod
    //This returns the HttpMethod type. It's used to determine the type if several endpoints are peresent
    private var method: HTTPMethod {
        switch self {
        case .getRepositories:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getRepositories:
            return EndPoint.repositories
        }
    }
    
    // MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
        var params: [String: Any] = [:]
        switch self {
        case .getRepositories(let page, let perPage):
            params = [JSONKey.language: "language:swift",
                      JSONKey.page: page,
                      JSONKey.perPage: perPage]
            return params
        }
    }
}
