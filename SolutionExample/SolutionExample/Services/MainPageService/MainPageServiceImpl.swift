final class MainPageServiceImpl: MainPageService {
 
    // MARK: - Properties
    private let networkClient: NetworkClient
    
    // MARK: - Dependencies
    init(networkClient: NetworkClient) {
        self.networkClient = networkClient
    }
    
    // MARK: - MainPageService
    func company() async -> Result<CompanyResponse, NetworkError> {
        await networkClient.send(request: CompanyRequest())
    }
}
