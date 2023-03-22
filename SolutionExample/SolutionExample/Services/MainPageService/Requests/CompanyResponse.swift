import Foundation

struct CompanyResponse: Decodable {
    let name: String
    let employees: [Employee]
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container()
        let nestedContainer = try container.nestedContainer(key: "company")
        
        name = try nestedContainer.decode(key: "name")
        employees = try nestedContainer.decode(key: "employees")
    }
}
