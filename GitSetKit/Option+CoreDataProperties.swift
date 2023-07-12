//
//  Option+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension Option {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Option> {
        return NSFetchRequest<Option>(entityName: "Option")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var value: String?
    @NSManaged public var dateField: DateField?
    @NSManaged public var inputField: InputField?
    @NSManaged public var optionField: OptionField?

}

extension Option : Identifiable {

}
