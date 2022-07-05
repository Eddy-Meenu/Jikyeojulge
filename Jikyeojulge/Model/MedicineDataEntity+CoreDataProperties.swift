//
//  MedicineDataEntity+CoreDataProperties.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/05.
//
//

import Foundation
import CoreData


extension MedicineDataEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MedicineDataEntity> {
        return NSFetchRequest<MedicineDataEntity>(entityName: "MedicineDataEntity")
    }

    @NSManaged public var efcyQesitm: String?
    @NSManaged public var intrcQesitm: String?
    @NSManaged public var itemImage: String?
    @NSManaged public var itemName: String?
    @NSManaged public var itemSeq: String?
    @NSManaged public var seQesitm: String?
    @NSManaged public var date: Date?

}

extension MedicineDataEntity : Identifiable {

}
