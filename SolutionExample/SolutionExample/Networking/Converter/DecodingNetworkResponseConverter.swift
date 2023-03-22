import Foundation

final class DecodingNetworkResponseConverter<Response>: NetworkResponseConverter where Response: Decodable {
    
    func decodeResponse(from data: Data) -> Response? {
        try? JSONDecoder().decode(Response.self, from: data)
    }
}
