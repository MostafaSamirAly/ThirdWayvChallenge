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
    
    init(_ product: ProductEntity) {
        self.id = Int(product.id)
        self.productDescription = product.productDescription!
        self.price = Int(product.price)
        self.image = Image(image: product.image!)
    }
}

struct Image: Codable {
    let width, height: Int
    let url: String
    
    init(image: ImageEntity) {
        self.width = Int(image.width)
        self.height = Int(image.height)
        self.url = image.url!
    }
}
