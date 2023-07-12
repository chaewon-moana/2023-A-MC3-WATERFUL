//
//  OptionField+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension OptionField {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<OptionField> {
        return NSFetchRequest<OptionField>(entityName: "OptionField")
    }

    @NSManaged public var multiple: Bool
    @NSManaged public var field: Field?
    @NSManaged public var options: NSSet?

}

// MARK: Generated accessors for options
extension OptionField {

    @objc(addOptionsObject:)
    @NSManaged public func addToOptions(_ value: Option)

    @objc(removeOptionsObject:)
    @NSManaged public func removeFromOptions(_ value: Option)

    @objc(addOptions:)
    @NSManaged public func addToOptions(_ values: NSSet)

    @objc(removeOptions:)
    @NSManaged public func removeFromOptions(_ values: NSSet)

}

extension OptionField : Identifiable {

}
