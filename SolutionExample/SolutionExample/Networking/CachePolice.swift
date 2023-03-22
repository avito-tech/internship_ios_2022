import Foundation

enum CachePolice {
    case cacheToDisk(CacheTime)
}

enum CacheTime: TimeInterval {
    case oneHour = 3600
}
