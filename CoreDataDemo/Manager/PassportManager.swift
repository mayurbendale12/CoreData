class PassportManager {
    private let passportDataRepository = PassportDataRepository()

    func create(passport: PassportModel) {
        passportDataRepository.create(passport: passport)
    }

    func fetch() -> [PassportModel] {
        return passportDataRepository.getAll() ?? []
    }

    func delete(passport: PassportModel) {
        passportDataRepository.delete(passport: passport)
    }
}
