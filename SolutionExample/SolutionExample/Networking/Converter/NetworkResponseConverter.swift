import Foundation

protocol NetworkResponseConverter: AnyObject {
    associatedtype Response
    
    func decodeResponse(from data: Data) -> Response?
}
