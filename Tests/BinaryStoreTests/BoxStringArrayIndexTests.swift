import Foundation
import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class BoxStringArrayIndexTests: XCTestCase {
    
    func test() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)

        for _ in 0..<25 {
            let offsetWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 2...8))! // offset 不能太小
            let stringWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 1...8))!
            let countWidth = BinaryStore.BitWidth(rawValue: Int.random(in: 1...8))!
            let encoding = randomEncoding()

            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + stringWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)

            var arr: [String] = []
            for _ in 0..<20 {
                arr.append(randomString(maxBytes: Int.random(in: 0..<128)))
            }

            _ = box.setStringArray(arr, index: index, offset: off, offsetWidth: offsetWidth, stringWidth: stringWidth, countWidth: countWidth, encoding: encoding)
            let result = box.getStringArray(index: index, offsetWidth: offsetWidth, sizeWidth: stringWidth, countWidth: countWidth, encoding: encoding)
            if result.isEmpty {
                pr("offsetWidth=\(offsetWidth), sizeWidth=\(stringWidth), countWidth=\(countWidth), encoding=\(encoding), index=\(index), indexSz=\(indexSz), off=\(off)")
            }
            XCTAssertEqual(result, arr)
        }
    }
}
