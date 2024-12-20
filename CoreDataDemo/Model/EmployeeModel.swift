import Foundation

struct EmployeeModel: CustomStringConvertible {
    let id: UUID
    let name: String
    let email: String
    let passport: PassportModel?

    var description: String {
        let passportDetails = "PassportId: \(passport?.passportId ?? ""), PlaceOfIssue: \(passport?.placeOfIssue ?? "")"
        return "Name: \(name), Email: \(email), \(passportDetails))"
    }
}
