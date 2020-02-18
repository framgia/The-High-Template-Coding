//
//  APIRouter.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//
import Alamofire

enum APIRouter: URLRequestConvertible {
    
    case getCharacters(offset: Int, limit: Int)
    case getCharacterComics(characterID: Int)
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        let url = try APIConfig.baseUrl.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        //Http method
        urlRequest.httpMethod = method.rawValue
        
        // Common Headers
        urlRequest.setValue(APIConfig.ContentType.json.rawValue, forHTTPHeaderField: APIConfig.HttpHeaderField.acceptType.rawValue)
        urlRequest.setValue(APIConfig.ContentType.json.rawValue, forHTTPHeaderField: APIConfig.HttpHeaderField.contentType.rawValue)
        
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
        case .getCharacters:
            return .get
        case .getCharacterComics:
            return .get
        }
    }
    
    private var path: String {
        switch self {
        case .getCharacters:
            return EndPoint.characters
        case .getCharacterComics(let characterID):
            return String(format: EndPoint.cComics, characterID)
        }
    }
    
    // MARK: - Parameters
    //This is the queries part, it's optional because an endpoint can be without parameters
    private var parameters: Parameters? {
//        let timeStamp = Date().currentTimeMillis()!
//        let hashString = "\(timeStamp)"+APIConfig.privateKey+APIConfig.publicKey
//        let md5Hash = CommonFunc.MD5(hashString)!
        var params: [String: Any] = [:]
        switch self {
        case .getCharacters(let offset, let limit):
            //A dictionary of the key (From the constants file) and its value is returned
//            params[JSONKeys.offset] = offset
//            params[JSONKeys.limit] = limit
            return params
        case .getCharacterComics:
            return params
        }
    }
}
