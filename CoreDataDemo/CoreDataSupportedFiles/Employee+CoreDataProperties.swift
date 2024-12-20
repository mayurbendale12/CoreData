//
//  Employee+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Mayur Bendale on 30/08/24.
//
//

import Foundation
import CoreData


extension Employee {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Employee> {
        return NSFetchRequest<Employee>(entityName: "Employee")
    }

    @NSManaged public var name: String?
    @NSManaged public var id: UUID?
    @NSManaged public var email: String?
    @NSManaged public var toPassport: Passport?

}

extension Employee : Identifiable {

}