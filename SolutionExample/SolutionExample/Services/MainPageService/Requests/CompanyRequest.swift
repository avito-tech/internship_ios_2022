final class CompanyRequest: NetworkRequest {
    typealias Response = CompanyResponse
    
    let path = "v3/1d1cb4ec-73db-4762-8c4b-0b8aa3cecd4c"
    let httpMethod: HttpMethod = .GET
    let cachePolice: CachePolice = .cacheToDisk(.oneHour)
}
