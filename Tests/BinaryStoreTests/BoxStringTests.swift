import Foundation
import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class BoxStringTests: XCTestCase {
    
    func test() {
        var buf = randomBuf(count: 1024)
        let box = BinaryStore.Box(&buf)
        
        for _ in 0..<25 {
            let s = randomString(maxBytes: Int.random(in: 0..<128))
            let off = Int.random(in: 0...1024)
            let sizeWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 1...8))!
            let encoding = randomEncoding()
            
            let sz = box.setString(s, offset: off, sizeWidth: sizeWidth, encoding: encoding)
            XCTAssertEqual(sz - sizeWidth.rawValue, encoding == .utf8 ? s.utf8.count : s.utf16.count * 2)
            XCTAssertEqual(box.getString(off, sizeWidth: sizeWidth, encoding: encoding), s)
        }
    }
}
