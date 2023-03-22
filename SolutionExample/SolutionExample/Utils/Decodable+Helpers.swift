extension Decoder {
    
    func container() throws -> KeyedDecodingContainer<GenericCodingKey> {
        try container(keyedBy: GenericCodingKey.self)
    }
}

extension KeyedDecodingContainer where Key == GenericCodingKey {
    func nestedContainer(key: String) throws -> KeyedDecodingContainer<GenericCodingKey> {
        try nestedContainer(keyedBy: GenericCodingKey.self, forKey: GenericCodingKey(key))
    }
    
    func decode<T: Decodable>(key: String) throws -> T {
        try decode(T.self, forKey: GenericCodingKey(key))
    }
}
