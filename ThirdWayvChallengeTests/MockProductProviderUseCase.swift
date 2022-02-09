//
//  MockProductProviderUseCase.swift
//  ThirdWayvChallengeTests
//
//  Created by Mostafa Samir on 09/02/2022.
//

import Foundation
@testable import ThirdWayvChallenge

class MockProductProviderUseCase: ProductListUseCase {
    func loadData(completion: @escaping ((Result<[Product], Error>) -> Void)) {
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: "MockJson", ofType: "json"),
              let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped) else {
                  completion(.failure(NSError(domain: "no data", code: 100, userInfo: nil)))
                  return
              }
        do {
            let products = try JSONDecoder().decode([Product].self, from: data)
            completion(.success(products))
        }catch {
            completion(.failure(NSError(domain: "decoding failed", code: 100, userInfo: nil)))
        }
        
        
    }
    
}
