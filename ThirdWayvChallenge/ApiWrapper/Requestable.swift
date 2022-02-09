//
//  Requestable.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 18/11/21.
//

import Foundation

typealias Parameters = [String: Any]

protocol Requestable {
    var method: NetworkConstants.HttpMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var parameters: Parameters? { get }
    var urlParameters: Parameters? { get }
    var headers: [NetworkConstants.HTTPHeaderFieldKey: NetworkConstants.HTTPHeaderFieldValue]? { get }
    var isWWWFormUrlEncoded: Bool? { get }
    var timeoutInterval: TimeInterval { get }
    func asURLRequest() throws -> URLRequest
}

extension Requestable {
    
    var method: NetworkConstants.HttpMethod {
        return .post
    }
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var headers:[NetworkConstants.HTTPHeaderFieldKey: NetworkConstants.HTTPHeaderFieldValue]? {
        return nil
    }
    
    var isWWWFormUrlEncoded: Bool? {
        return false
    }
    
    var urlParameters: Parameters? {
        return nil
    }
    
    var timeoutInterval: TimeInterval {
        return 5
    }
    
    
    // MARK: - Methods
    func asURLRequest() throws -> URLRequest {
        let urlPath = baseURL + path
        
        guard let url = URL(string : urlPath.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed) ?? urlPath) else { throw NetworkError.badAPIRequest }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.addValue(NetworkConstants.HTTPHeaderFieldValue.json.rawValue,
                            forHTTPHeaderField: NetworkConstants.HTTPHeaderFieldKey.acceptType.rawValue)
        if headers != nil {
            for (key, value) in headers! {
                urlRequest.setValue(value.rawValue, forHTTPHeaderField: key.rawValue)
            }
        }
        switch method {
            case .get:
                try ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, parameters: urlParameters)
            default:
                if isWWWFormUrlEncoded ?? false {
                    try ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, parameters: urlParameters)
                } else {
                    try ParameterEncoding.urlEncoding.encode(urlRequest: &urlRequest, parameters: urlParameters)
                    try ParameterEncoding.jsonEncoding.encode(urlRequest: &urlRequest, parameters: parameters)
                }
        }
        urlRequest.timeoutInterval = timeoutInterval
        return urlRequest
    }
}
