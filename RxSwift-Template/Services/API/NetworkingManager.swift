//
//  NetworkingManager.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import Foundation
import Alamofire

struct NetworkingManager {
    // MARK: - The request function to get results in an Observable
    static func request<T: Codable> (_ urlConvertible: URLRequestConvertible) -> Observable<T> {
        //Create an RxSwift observable, which will be the one to call the request when subscribed to
        Logger.info("LINK REQUEST: " + (String(describing: urlConvertible.urlRequest?.url)))
        return Observable<T>.create { observer in
            //Trigger the HttpRequest using AlamoFire (AF)
            let request = Alamofire.request(urlConvertible).responseJSON { (response) in
                switch response.result {
                case .success(let value):
                    //Everything is fine, return the value in onNext
                    guard let jsondData = try? JSONSerialization.data(withJSONObject: value, options: []),
                        let data = try? JSONDecoder().decode(T.self, from: jsondData) else {
                            Logger.info("Parsing data error: " + (String(describing: urlConvertible.urlRequest?.url)) + "value: \(value)")
                            observer.onError(APIError.error(APIError.parsingDataErrorCode))
                            return
                    }
                    guard let statusCode = response.response?.statusCode else {
                        return  observer.onError(APIError.error(APIError.defaultErrorCode))
                    }
                    switch statusCode {
                    case 200..<300:
                        observer.onNext(data)
                        observer.onCompleted()
                    default:
                        observer.onError(APIError.error(statusCode))
                    }
                    
                case .failure(let error):
                    //Something went wrong, switch on the status code and return the error
                    if let statusCode = response.response?.statusCode {
                        observer.onError(APIError
                            .error(statusCode))
                        return
                    }
                    observer.onError(error)
                }
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}
