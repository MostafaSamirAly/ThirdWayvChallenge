//
//  ProductEntity+CoreDataProperties.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 07/02/2022.
//
//

import Foundation
import CoreData


extension ProductEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductEntity> {
        return NSFetchRequest<ProductEntity>(entityName: "ProductEntity")
    }

    @NSManaged public var id: Int32
    @NSManaged public var price: Int32
    @NSManaged public var productDescription: String?
    @NSManaged public var image: ImageEntity?

}

extension ProductEntity : Identifiable {

}
