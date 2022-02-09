//
//  ProductList.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import Foundation

enum ProductListAPI: Requestable {
    case products
    
    var baseURL: String {
        return NetworkConstants.baseURL
    }
    
    var path: String {
        switch self {
            case .products:
                return "products/get"
        }
    }
    
    var method: NetworkConstants.HttpMethod {
        switch self {
            case .products:
                return .get
        }
    }
    
    var parameters: Parameters? {
        return nil
    }
    
    var urlParameters: Parameters? {
        return nil
    }
    
    var isWWWFormUrlEncoded: Bool? {
        switch self {
            case .products:
                return false
        }
    }
    
    var headers: [NetworkConstants.HTTPHeaderFieldKey :
                    NetworkConstants.HTTPHeaderFieldValue]? {
        switch self {
            case .products:
                return [.acceptType: .json]
        }
    }
}
