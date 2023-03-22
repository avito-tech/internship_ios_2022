import Foundation

final class NetworkResponseConverterOf<Response>: NetworkResponseConverter {
    
    // MARK: - Callbacks
    private let decodeResponse: (Data) -> Response?
    
    // MARK: - Init
    init<Converter: NetworkResponseConverter>(
        converter: Converter
    ) where Converter.Response == Response {
        decodeResponse = { data in
            converter.decodeResponse(from: data)
        }
    }
    
    // MARK: - NetworkResponseConverter
    func decodeResponse(from data: Data) -> Response? {
        decodeResponse(data)
    }
}
