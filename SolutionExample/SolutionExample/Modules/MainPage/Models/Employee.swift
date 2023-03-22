struct Employee: Codable {
    
    let name: String
    let skills: [String]
    let phoneNumber: String

    enum CodingKeys: String, CodingKey {
        case name
        case skills
        case phoneNumber = "phone_number"
    }
}
