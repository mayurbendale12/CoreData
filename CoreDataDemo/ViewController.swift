//
//  ViewController.swift
//  CoreDataDemo
//
//  Created by Mayur Bendale on 29/08/24.
//

import UIKit

class ViewController: UIViewController {
    private let employeeManager = EmployeeManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        print(path as Any)

//        createEmployee()
        fetchEmployee()
    }

    private func createEmployee() {
        let employee = EmployeeModel(id: UUID(),
                                     name: "Mayur",
                                     email: "msb@gmail.com",
                                     passport: PassportModel(id: UUID(),
                                                             passportId: "ABFZTY123",
                                                             placeOfIssue: "Pune"))
        employeeManager.create(employee: employee)
    }

    private func fetchEmployee() {
        print(employeeManager.fetch().description)
    }
}
