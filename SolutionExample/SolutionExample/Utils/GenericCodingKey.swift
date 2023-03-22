final class GenericCodingKey: CodingKey {

    // MARK: - Properties
    private let value: String
    
    // MARK: - CodingKey
    var intValue: Int? { nil }
    var stringValue: String { value }
    
    // MARK: - Init
    init?(stringValue value: String) { nil }
    init?(intValue: Int) { nil }
    
    init(_ value: String) {
        self.value = value
    }
}
