import CoreData

class EmployeeMigrationPolicy: NSEntityMigrationPolicy {
    override func createDestinationInstances(forSource sInstance: NSManagedObject, in mapping: NSEntityMapping, manager: NSMigrationManager) throws {
        if sInstance.entity.name == "Employee" {
            let id = sInstance.value(forKey: "id") as? UUID
            let firstName = sInstance.value(forKey: "firstname") as? String
            let jobTitle = sInstance.value(forKey: "jobtitle") as? String
            let email = sInstance.value(forKey: "email") as? String
            let birthdate = sInstance.value(forKey: "birthdate") as? String

            let newEmployeeEntity = NSEntityDescription.insertNewObject(forEntityName: "Employee", into: manager.destinationContext)
            newEmployeeEntity.setValue(id, forKey: "id")
            newEmployeeEntity.setValue(firstName, forKey: "firstname")
            newEmployeeEntity.setValue(jobTitle, forKey: "jobtitle")
            newEmployeeEntity.setValue(email, forKey: "email")
            newEmployeeEntity.setValue(birthdate?.toDate(), forKey: "birthdate") //birthdate data type changes from String to Date, so peroforming heavyweight migration
        }
    }
}
