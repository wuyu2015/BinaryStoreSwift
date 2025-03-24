import Foundation
import XCTest
@testable import BinaryStore

final class BoxStringArrayTests: XCTestCase {
    
    func test() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        for _ in 0..<25 {
            let off = Int.random(in: 0...1024)
            let countWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 1...8))!
            let sizeWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 1...8))!
            let encoding = randomEncoding()
            
            var arr: [String] = []
            for _ in 0..<20 {
                arr.append(randomString(maxBytes: Int.random(in: 0..<128)))
            }
            
            _ = box.setStringArray(arr, offset: off, arrayWidth: countWidth, stringWidth: sizeWidth, encoding: encoding)
            XCTAssertEqual(box.getStringArray(offset: off, arrayWidth: countWidth, stringWidth: sizeWidth, encoding: encoding), arr)
        }
    }
}
