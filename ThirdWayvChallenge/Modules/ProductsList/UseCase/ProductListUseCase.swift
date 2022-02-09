//
//  ProductListUseCase.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 06/02/2022.
//

import Foundation

protocol ProductListUseCase {
    func loadData(completion: @escaping ((Result<[Product], Error>,_ fromCache: Bool) -> Void))
}

final class ProductListProvider: ProductListUseCase {
    init() {
        
    }
    func loadData(completion: @escaping ((Result<[Product], Error>,_ fromCache: Bool) -> Void)) {
        Api().fetchData(request: ProductListAPI.products,
                        mappingClass: [Product].self) { result in
            switch result {
                case .success(let products):
                    NetworkMonitor.shared.isConnected.remove(observer: self)
                    completion(.success(products), false)
                    DispatchQueue.main.async {
                        CoreDataManager.shared.insert(products: products)
                    }
                case .failure(let error):
                    if let error = error as? NetworkError {
                        switch error {
                            case .noInternet:
                                // start observing network to retry the request when network connection is restored
                                NetworkMonitor.shared.isConnected.observe(on: self) { [weak self] isConnected in
                                    guard let isConnected = isConnected,
                                    isConnected == true else { return }
                                    self?.loadData(completion: completion)
                                }
                            default:
                                break
                        }
                    }
                    completion(.failure(error), false)
                    
                    switch CoreDataManager.shared.fetchProducts() {
                            // will complete with the local data from core data
                        case .success(let products):
                            completion(.success(products), true)
                        case .failure(let error):
                            completion(.failure(error), true)
                    }
            }
        }
    }
}
