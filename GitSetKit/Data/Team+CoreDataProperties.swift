//
//  Team+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension Team {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }

    @NSManaged public var desc: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var template: String?
    @NSManaged public var fields: NSSet?

}

// MARK: Generated accessors for fields
extension Team {

    @objc(addFieldsObject:)
    @NSManaged public func addToFields(_ value: Field)

    @objc(removeFieldsObject:)
    @NSManaged public func removeFromFields(_ value: Field)

    @objc(addFields:)
    @NSManaged public func addToFields(_ values: NSSet)

    @objc(removeFields:)
    @NSManaged public func removeFromFields(_ values: NSSet)

}

extension Team : Identifiable {

}
