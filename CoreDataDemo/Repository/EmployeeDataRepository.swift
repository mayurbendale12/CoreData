import CoreData
import Foundation

protocol EmployeeRepository {
    func create(employee: EmployeeModel)
    func getAll() -> [EmployeeModel]?
    func get(by id: UUID) -> EmployeeModel?
    func update(employee: EmployeeModel)
    func delete(employee: EmployeeModel)
}

class EmployeeDataRepository: EmployeeRepository {
    func create(employee: EmployeeModel) {
        let cdEmployee = Employee(context: PersistentStorage.shared.context)
        cdEmployee.id = employee.id
        cdEmployee.name = employee.name
        cdEmployee.email = employee.email

        if let passport = employee.passport {
            let cdPassport = Passport(context: PersistentStorage.shared.context)
            cdPassport.id = passport.id
            cdPassport.passportId = passport.passportId
            cdPassport.placeOfIssue = passport.placeOfIssue
            cdEmployee.toPassport = cdPassport
        }
        PersistentStorage.shared.saveContext()
    }
    
    func getAll() -> [EmployeeModel]? {
        do {
            let results = try PersistentStorage.shared.context.fetch(Employee.fetchRequest())
            var employeeModels = [EmployeeModel]()
            results.forEach { employee in
                if let id = employee.id {
                    employeeModels.append(EmployeeModel(id: id,
                                                        name: employee.name ?? "",
                                                        email: employee.email ?? "",
                                                        passport: PassportModel(id: employee.toPassport?.id ?? UUID(),
                                                                                passportId: employee.toPassport?.passportId ?? "",
                                                                                placeOfIssue: employee.toPassport?.placeOfIssue ?? "")))
                }
            }
            return employeeModels
        } catch(let error) {
            debugPrint(error)
        }
        return nil
    }
    
    func get(by id: UUID) -> EmployeeModel? {
        guard let cdEmployee = getCoreDataEmployee(by: id) else { return nil }
        return EmployeeModel(id: id,
                             name: cdEmployee.name ?? "",
                             email: cdEmployee.email ?? "",
                             passport: PassportModel(id: cdEmployee.toPassport?.id ?? UUID(),
                                                     passportId: cdEmployee.toPassport?.passportId ?? "",
                                                     placeOfIssue: cdEmployee.toPassport?.placeOfIssue ?? ""))
    }
    
    func update(employee: EmployeeModel) {
        let cdEmployee = getCoreDataEmployee(by: employee.id)
        cdEmployee?.email = employee.email
        cdEmployee?.name = employee.name
        PersistentStorage.shared.saveContext()
    }
    
    func delete(employee: EmployeeModel) {
        guard let cdEmployee = getCoreDataEmployee(by: employee.id) else { return }
        PersistentStorage.shared.context.delete(cdEmployee)
        PersistentStorage.shared.saveContext()
    }

    private func getCoreDataEmployee(by id: UUID) -> Employee? {
        let fetchRequest = NSFetchRequest<Employee>(entityName: "Employee")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
//        fetchRequest.fetchLimit = 100
        fetchRequest.sortDescriptors = [NSSortDescriptor(keyPath: \Employee.name, ascending: true)]
        do {
            return try PersistentStorage.shared.context.fetch(fetchRequest).first
        } catch(let error) {
            debugPrint(error)
        }
        return nil
    }
}
