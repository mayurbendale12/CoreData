import Foundation

class EmployeeManager {
    private let employeeDataRepository = EmployeeDataRepository()

    func create(employee: EmployeeModel) {
        employeeDataRepository.create(employee: employee)
    }

    func fetch() -> [EmployeeModel] {
        return employeeDataRepository.getAll() ?? []
    }

    func get(by id: UUID) -> EmployeeModel? {
        return employeeDataRepository.get(by: id)
    }

    func update(employee: EmployeeModel) {
        employeeDataRepository.update(employee: employee)
    }

    func delete(employee: EmployeeModel) {
        employeeDataRepository.delete(employee: employee)
    }
}
