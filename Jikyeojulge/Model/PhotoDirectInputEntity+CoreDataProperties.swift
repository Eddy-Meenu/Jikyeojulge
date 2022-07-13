//
//  PhotoDirectInputEntity+CoreDataProperties.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/13.
//
//

import Foundation
import CoreData


extension PhotoDirectInputEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PhotoDirectInputEntity> {
        return NSFetchRequest<PhotoDirectInputEntity>(entityName: "PhotoDirectInputEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var medicalTitle: String?
    @NSManaged public var descriptions: String?
    @NSManaged public var photo: Data?

}

extension PhotoDirectInputEntity : Identifiable {

}
