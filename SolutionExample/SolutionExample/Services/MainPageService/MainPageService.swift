protocol MainPageService: AnyObject {
    func company() async -> Result<CompanyResponse, NetworkError>
}
