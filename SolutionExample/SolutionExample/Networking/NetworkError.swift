enum NetworkError: Error {
    case cantBuildUrlFromRequest
    case noInternetConnection
    case parsingFailure
    case networkError
    case timeout
}
