//
//  ConstantField+CoreDataProperties.swift
//  GitSetKit
//
//  Created by 최명근 on 2023/07/12.
//
//

import Foundation
import CoreData


extension ConstantField {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConstantField> {
        return NSFetchRequest<ConstantField>(entityName: "ConstantField")
    }

    @NSManaged public var string: String?
    @NSManaged public var field: Field?

}

extension ConstantField : Identifiable {

}
