import Foundation

protocol NetworkRequest: AnyObject {
    associatedtype Response
    
    var path: String { get }
    var httpMethod: HttpMethod { get }
    var cachePolice: CachePolice { get }
    var responseConverter: NetworkResponseConverterOf<Response> { get }
}

extension NetworkRequest where Response: Decodable {
    var responseConverter: NetworkResponseConverterOf<Response> {
        NetworkResponseConverterOf(converter: DecodingNetworkResponseConverter())
    }
}
