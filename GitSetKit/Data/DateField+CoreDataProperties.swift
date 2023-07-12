//
//  DateField+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension DateField {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DateField> {
        return NSFetchRequest<DateField>(entityName: "DateField")
    }

    @NSManaged public var format: String?
    @NSManaged public var field: Field?

}

extension DateField : Identifiable {

}
