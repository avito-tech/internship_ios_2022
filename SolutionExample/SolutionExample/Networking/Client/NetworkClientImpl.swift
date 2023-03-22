import Foundation

final class NetworkClientImpl: NetworkClient {
    
    // MARK: - Properties
    private let urlSession: URLSession = URLSession(configuration: .default)
    
    // MARK: - Dependencies
    private let urlCache: URLCache
    private let userDefaults: UserDefaults
    private let requestBuilder: RequestBuilder
    
    // MARK: - Init
    init(
        urlCache: URLCache = URLCache(),
        userDefaults: UserDefaults = UserDefaults.standard,
        requestBuilder: RequestBuilder = RequestBuilderImpl()
    ) {
        self.urlCache = urlCache
        self.userDefaults = userDefaults
        self.requestBuilder = requestBuilder
    }
    
    // MARK: - NetworkClient
    func send<Request: NetworkRequest>(
        request: Request
    ) async -> Result<Request.Response, NetworkError> {
        
        switch requestBuilder.build(request: request) {
        case let .success(urlRequest):
            return await send(
                urlRequest: urlRequest,
                cachePolice: request.cachePolice,
                responseConverter: request.responseConverter
            )
            
        case let .failure(error):
            return .failure(error)
            
        }
    }
    
    // MARK: - Private methods - Send methods
    private func send<Converter: NetworkResponseConverter>(
        urlRequest: URLRequest,
        cachePolice: CachePolice,
        responseConverter: Converter
    ) async -> Result<Converter.Response, NetworkError> {
        if let cachedData = cachedData(urlRequest: urlRequest) {
            return decodeResponse(from: cachedData, responseConverter: responseConverter)
        }
        
        do {
            let (data, response) = try await urlSession.data(for: urlRequest)
            
            cacheDataIfNeeded(
                urlRequest: urlRequest,
                cachePolice: cachePolice,
                cachedURLResponse: CachedURLResponse(response: response, data: data)
            )
            
            return decodeResponse(from: data, responseConverter: responseConverter)
        } catch {
            switch (error as? URLError)?.code {
            case .some(.notConnectedToInternet):
                return .failure(.noInternetConnection)
            case .some(.timedOut):
                return .failure(.timeout)
            default:
                return .failure(.networkError)
            }
        }
    }
    
    // MARK: - Private methods - Decode methods
    func decodeResponse<Converter: NetworkResponseConverter>(
        from data: Data,
        responseConverter: Converter
    ) -> Result<Converter.Response, NetworkError> {
        if let response = responseConverter.decodeResponse(from: data) {
            return .success(response)
        }
        return .failure(.parsingFailure)
    }
    
    // MARK: - Private methods - Cache methods
    private func cacheDataIfNeeded(
        urlRequest: URLRequest,
        cachePolice: CachePolice,
        cachedURLResponse: CachedURLResponse
    ) {
        switch cachePolice {
        case let .cacheToDisk(cacheTime):
            guard let urlString = urlRequest.url?.absoluteString else { return }
            
            userDefaults.set(
                cacheTime.rawValue + Date.timeIntervalSinceReferenceDate,
                forKey: Spec.responseCacheKey(urlString: urlString)
            )
            urlCache.storeCachedResponse(cachedURLResponse, for: urlRequest)
        }
    }
    
    private func cachedData(urlRequest: URLRequest) -> Data? {
        guard let urlString = urlRequest.url?.absoluteString,
              let storedData = userDefaults.object(forKey: Spec.responseCacheKey(urlString: urlString)),
              let expirationTimestamp = storedData as? TimeInterval
        else { return nil }
        
        guard expirationTimestamp > Date.timeIntervalSinceReferenceDate else {
            userDefaults.removeObject(forKey: Spec.responseCacheKey(urlString: urlString))
            return nil
        }
              
        return urlCache.cachedResponse(for: urlRequest)?.data
    }
}

// MARK: - Spec
fileprivate enum Spec {
    static func responseCacheKey(urlString: String) -> String {
        "ExpirationTimestamp_\(urlString)"
    }
}
