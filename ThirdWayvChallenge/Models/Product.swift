//
//  Product.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 05/02/2022.
//

import Foundation

struct Product: Codable {
    let id: Int
    let productDescription: String
        let image: Image
        let price: Int
    }

struct Image: Codable {
        let width, height: Int
        let url: String
    }
