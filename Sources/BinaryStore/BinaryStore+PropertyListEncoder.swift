import Foundation

extension BinaryStore {
    static let binaryPlistEncoder: PropertyListEncoder = {
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .binary
        return encoder
    }()
}
