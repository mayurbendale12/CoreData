import Foundation

struct PassportModel: CustomStringConvertible {
    let id: UUID
    let passportId: String
    let placeOfIssue: String

    var description: String {
        return "\(passportId) \(placeOfIssue)"
    }
}
