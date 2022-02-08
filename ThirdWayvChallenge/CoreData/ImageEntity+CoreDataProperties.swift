//
//  ImageEntity+CoreDataProperties.swift
//  ThirdWayvChallenge
//
//  Created by Mostafa Samir on 07/02/2022.
//
//

import Foundation
import CoreData


extension ImageEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageEntity> {
        return NSFetchRequest<ImageEntity>(entityName: "ImageEntity")
    }

    @NSManaged public var height: Int32
    @NSManaged public var url: String?
    @NSManaged public var width: Int32
    @NSManaged public var product: ProductEntity?

}

extension ImageEntity : Identifiable {

}
