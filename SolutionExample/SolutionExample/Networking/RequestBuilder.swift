import Foundation

protocol RequestBuilder: AnyObject {
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError>
}

final class RequestBuilderImpl: RequestBuilder {
    
    // MARK: - Data
    private let host: String
    
    // MARK: - Init
    init(host: String = "run.mocky.io") {
        self.host = host
    }
    
    // MARK: - RequestBuilder
    func build(request: any NetworkRequest) -> Result<URLRequest, NetworkError> {
        guard let url = URL(string: "https://\(host)/\(request.path)") else {
            return .failure(.cantBuildUrlFromRequest)
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 15)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        return .success(urlRequest)
    }
}
