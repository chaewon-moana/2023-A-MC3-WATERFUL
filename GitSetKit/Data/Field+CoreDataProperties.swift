//
//  Field+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension Field {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Field> {
        return NSFetchRequest<Field>(entityName: "Field")
    }

    @NSManaged public var desc: String?
    @NSManaged public var fieldName: String?
    @NSManaged public var type: String?
    @NSManaged public var dateField: DateField?
    @NSManaged public var inputField: InputField?
    @NSManaged public var optionField: OptionField?
    @NSManaged public var team: Team?
    @NSManaged public var constantField: ConstantField?

}

extension Field : Identifiable {

}
