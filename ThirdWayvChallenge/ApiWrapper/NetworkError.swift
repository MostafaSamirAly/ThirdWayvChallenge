//
//  Product.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//


import Foundation

public enum NetworkError: Error {
    case noInternet
    case badAPIRequest
    case unauthorized
    case unknown(message: String)
    case serverError
    case timeout
    case noUrl
    case encodingFailed
}

extension NetworkError: LocalizedError {
    public var errorDescription: String? {
        switch self {
            case .noInternet:           return "No Internet Connection"
            case .badAPIRequest:        return "Bad Api Request"
            case .unauthorized:         return "UnAuthorized"
            case .unknown(let message): return message
            case .serverError:          return "Internal Server Error"
            case .timeout:              return "Connection Timed Out"
            case .noUrl:                return "Not avalid url"
            case .encodingFailed:       return "Encoding Failed"
        }
    }
}
