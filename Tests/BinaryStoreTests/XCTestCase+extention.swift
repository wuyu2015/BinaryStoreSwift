import Foundation
import XCTest
@testable import BinaryStore

extension XCTestCase {
    func randomBitWidth() -> BinaryStore.BitWidth {
        return BinaryStore.BitWidth(rawValue: Int.random(in: BinaryStore.BitWidth.min...BinaryStore.BitWidth.max))!
    }
    
    func randomBuf(count: Int = 1024) -> [UInt8] {
        return [UInt8](repeating: 0, count: count).map { _ in UInt8.random(in: 0...255) }
    }
    
    func randomString(length: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789你好世界随机文本测试示例苹果香蕉电脑手机😀😂🥳🎉🚀❤️🌍🔥👍😎"
        return String((0..<length).map { _ in characters.randomElement()! })
    }
    
    func randomString(maxBytes: Int) -> String {
        let characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789你好世界随机文本测试示例苹果香蕉电脑手机😀😂🥳🎉🚀❤️🌍🔥👍😎"
        var result = ""
        var byteCount = 0
        
        // 随机生成字符直到字节数超过 maxBytes
        while byteCount < maxBytes {
            let randomChar = characters.randomElement()!
            let charByteCount = String(randomChar).data(using: .utf8)?.count ?? 0
            
            // 判断是否会超出最大字节数，如果超出则停止
            if byteCount + charByteCount > maxBytes {
                break
            }
            
            result.append(randomChar)
            byteCount += charByteCount
        }
        
        return result
    }
    
    func randomEncoding() -> String.Encoding {
        let arr: [String.Encoding] = [.utf8, .utf16]
        return arr.randomElement()!
    }
}
