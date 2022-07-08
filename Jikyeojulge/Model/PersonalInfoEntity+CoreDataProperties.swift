//
//  PersonalInfoEntity+CoreDataProperties.swift
//  Jikyeojulge
//
//  Created by 지준용 on 2022/07/04.
//
//

import Foundation
import CoreData


extension PersonalInfoEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PersonalInfoEntity> {
        return NSFetchRequest<PersonalInfoEntity>(entityName: "PersonalInfoEntity")
    }

    @NSManaged public var birth: String?
    @NSManaged public var bloodType: String?
    @NSManaged public var contact1: String?
    @NSManaged public var contact2: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var photoImage: Data?
    @NSManaged public var medicalRecord: String?

}

extension PersonalInfoEntity : Identifiable {

}
