//
//  ProductListUseCase.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import Foundation

protocol ProductListUseCase {
    func loadData(completion: @escaping ((Result<[Product], Error>) -> Void),
                  cache:@escaping ((Result<[Product], Error>) -> Void))
}

final class ProductListProvider: ProductListUseCase {
    
    func loadData(completion: @escaping ((Result<[Product], Error>) -> Void),
                                         cache: @escaping ((Result<[Product], Error>) -> Void)) {
        if NetworkMonitor.shared.netOn {
            Api().fetchData(request: ProductListAPI.products,
                            mappingClass: [Product].self) { result in
                switch result {
                    case .success(let products):
                        completion(.success(products))
                        DispatchQueue.main.async {
                            CoreDataManager.shared.insert(products: products)
                        }
                    case .failure(let error):
                        completion(.failure(error))
                }
            }
        }else {
            switch CoreDataManager.shared.fetchProducts() {
                case .success(let products):
                    cache(.success(products))
                case .failure(let error):
                    cache(.failure(error))
            }
        }
    }
}
