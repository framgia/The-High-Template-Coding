//
//  NetworkingManager.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import Foundation
import Alamofire


typealias completionHandler<T> = (_ data: T?, _ error: Error?) -> Void

//demo

struct DemoObject: Codable {
    var name = ""
}

struct NetworkingManager {
    
    static func getCharacters(offset: Int, limit: Int, completion: @escaping completionHandler<DemoObject>) {
        request(APIRouter.getCharacters(offset: offset, limit: limit), completion: completion)
    }

    
    // MARK: - The request function to get results in an Observable
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible, completion: @escaping completionHandler<T>) {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        print(urlConvertible.urlRequest?.url)
        AF.request(urlConvertible).responseJSON { (response) in
            switch response.result {
            case .success(let value):
                //Everything is fine, return the value in onNext
                guard let jsondData = try? JSONSerialization.data(withJSONObject: value, options: []),
                    let data = try? JSONDecoder().decode(T.self, from: jsondData) else {
                        completion(nil, APIError.error(statusCode: APIError.parsingDataErrorCode))
                        return
                }
                completion(data, nil)
            case .failure:
                //Something went wrong, switch on the status code and return the error
                completion(nil, APIError.error(statusCode: response.response?.statusCode))
            }
        }
    }
}
