//
//  ProductListUseCase.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import Foundation

protocol ProductListUseCase {
    func loadData(completion: @escaping ((Result<[Product], NetworkError>) -> Void))
}

final class ProductListProvider: ProductListUseCase {
    
    func loadData(completion: @escaping ((Result<[Product], NetworkError>) -> Void)) {
        
        Api().fetchData(request: ProductListAPI.products,
                        mappingClass: [Product].self,
                        completion: completion)
    }
}
