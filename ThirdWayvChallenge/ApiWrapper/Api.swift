//
//  Product.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//


import Foundation


class Api {
    
    func fetchData<T: Decodable>(request: Requestable,
                               mappingClass: T.Type,
                               completion: @escaping (Result<T, Error>) -> Void) {
        do {
            let urlRequest = try request.asURLRequest()
            
            let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
                if let error = error {
                    completion(.failure(NetworkError.unknown(message: error.localizedDescription)))
                }else {
                    guard let data = data else {
                        completion(.failure(NetworkError.badAPIRequest))
                        return
                    }
                    do {
                        let decoder = JSONDecoder()
                        let responseModel = try decoder.decode(T.self, from: data)
                        completion(.success(responseModel))
                    }catch {
                        completion(.failure(NetworkError.unknown(message: error.localizedDescription)))
                    }
                }
            }
            task.resume()
        } catch {
            completion(.failure(NetworkError.unknown(message: error.localizedDescription)))
        }
    }
}
