import CoreData
import Foundation

protocol PassportRepository {
    func create(passport: PassportModel)
    func getAll() -> [PassportModel]?
    func delete(passport: PassportModel)
}

class PassportDataRepository: PassportRepository {
    func create(passport: PassportModel) {
        let cdPassport = Passport(context: PersistentStorage.shared.context)
        cdPassport.id = passport.id
        cdPassport.passportId = passport.passportId
        cdPassport.placeOfIssue = passport.placeOfIssue
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [PassportModel]? {
        do {
            let results = try PersistentStorage.shared.context.fetch(Passport.fetchRequest())
            var passportModels = [PassportModel]()
            results.forEach { passport in
                if let id = passport.id {
                    passportModels.append(PassportModel(id: id, passportId: passport.passportId ?? "", placeOfIssue: passport.placeOfIssue ?? ""))
                }
            }
            return passportModels
        } catch(let error) {
            debugPrint(error)
        }
        return nil
    }

    func delete(passport: PassportModel) {
        guard let cdPassport = getCoreDataPassport(by: passport.id) else { return }
        PersistentStorage.shared.context.delete(cdPassport)
        PersistentStorage.shared.saveContext()
    }

    private func getCoreDataPassport(by id: UUID) -> Passport? {
        let fetchRequest = NSFetchRequest<Passport>(entityName: "Passport")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate

        do {
            return try PersistentStorage.shared.context.fetch(fetchRequest).first
        } catch(let error) {
            debugPrint(error)
        }
        return nil
    }
}
