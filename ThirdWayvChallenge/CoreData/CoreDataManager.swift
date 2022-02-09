//
//  CoreDataManager.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 07/02/2022.
//

import CoreData
import UIKit.UIApplication

enum ProductEntityAttributes: String, CaseIterable {
    case id
    case image
    case productDescription
    case price
}

final class CoreDataManager {
    static let shared = CoreDataManager()
    let managedContext: NSManagedObjectContext
    private init() {
            managedContext = CoreDataConfiguration.shared.persistentContainer.viewContext
    }
    
    func fetchProducts() -> Result<[Product], Error> {
        let productsRequest = ProductEntity.fetchRequest()
        do {
            let retrievedData = try managedContext.fetch(productsRequest)
                return .success(retrievedData.compactMap { Product(product:$0) })
        }catch {
            return .failure(error)
        }
    }
    
    func insert(products: [Product]) {
        deleteAllProducts()
        for product in products {
            let productToInsert = ProductEntity(context: managedContext)
            let productImage = ImageEntity(context: managedContext)
            productImage.height = Int32(product.image.height)
            productImage.width = Int32(product.image.width)
            productImage.url = product.image.url
            productToInsert.id = Int32(product.id)
            productToInsert.image = productImage
            productToInsert.price = Int32(product.price)
            productToInsert.productDescription = product.productDescription
            do {
                try managedContext.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func deleteAllProducts() {
        let fetchRequest = ProductEntity.fetchRequest()
        if let result = try? managedContext.fetch(fetchRequest) {
            for object in result {
                managedContext.delete(object)
                do{
                    try managedContext.save()
                } catch {
                    print(error)
                }
            }
        }
    }
}


