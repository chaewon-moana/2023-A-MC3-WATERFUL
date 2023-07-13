//
//  InputField+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension InputField {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<InputField> {
        return NSFetchRequest<InputField>(entityName: "InputField")
    }

    @NSManaged public var placeHolder: String?
    @NSManaged public var field: Field?

}

extension InputField : Identifiable {

}
