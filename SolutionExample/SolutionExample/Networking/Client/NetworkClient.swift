import Foundation

protocol NetworkClient: AnyObject {
    func send<Request: NetworkRequest>(
        request: Request
    ) async -> Result<Request.Response, NetworkError>
}
