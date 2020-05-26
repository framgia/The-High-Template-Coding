//
//  APIError.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation

struct APIError {
    
    static let defaultErrorCode              = 9999
    static let parsingDataErrorCode          = 6666
    static let invalidSSL                    = -1202
    static let noInternetConnection          = -1009
    static let unauthorized                  = "No access or authentication failed"
    static let parseDataError                = "Parsing data error"
    static let internalServerError           = "Internal server error"
    static let serviceTemporarilyUnavailable = "The upper limit of the number of simultaneous access has been exceeded due to access concentration"
    static let defaultError                  = "Unable to connect to server"
    static let forbiden                      = "You don't have permission to access [directory] on this server"
    static let notFound                      = "API not found"
    static let somethingWrong                = "Something wrong"
    static func error(_ statusCode: Int?) -> Error {
        let _statusCode = statusCode ?? defaultErrorCode
        switch statusCode {
        case 6666:
            return errorForStatusCode(statusCode: _statusCode, errorDescription: self.parseDataError)
        case 401:
            return errorForStatusCode(statusCode: _statusCode, errorDescription: self.unauthorized)
        case 403:
            return errorForStatusCode(statusCode: _statusCode, errorDescription: self.forbiden)
        case 404:
           return errorForStatusCode(statusCode: _statusCode, errorDescription: self.notFound)
        case 500:
            return  errorForStatusCode(statusCode: _statusCode, errorDescription: self.internalServerError)
        case 503:
            return errorForStatusCode(statusCode: _statusCode, errorDescription: self.serviceTemporarilyUnavailable)
        default:
            return errorForStatusCode(statusCode: self.defaultErrorCode, errorDescription: self.defaultError)
        }
    }
    
    static func errorForStatusCode(statusCode: Int, errorDescription: String) -> Error {
        return NSError(domain: "", code: statusCode, userInfo: [NSLocalizedDescriptionKey: errorDescription ])
    }
}
