//
//  Passport+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Mayur Bendale on 30/08/24.
//
//

import Foundation
import CoreData


extension Passport {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Passport> {
        return NSFetchRequest<Passport>(entityName: "Passport")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var passportId: String?
    @NSManaged public var placeOfIssue: String?
    @NSManaged public var toEmployee: Employee?

}

extension Passport : Identifiable {

}
