import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class DemoTests: XCTestCase {
    func testDemoInt() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        box.setInt(65535, offset: 0, itemWidth: .bit16)
        box.setInt(65536, offset: 2, itemWidth: .bit24)
        box.setInt(13888888888, offset: 5, itemWidth: .bit40)
        pr(box.count)
        pr(buf)
        
        let n1: UInt16 = box.getInt(offset: 0, itemWidth: .bit16)
        let n2: UInt32 = box.getInt(offset: 2, itemWidth: .bit24)
        let n3: Int = box.getInt(offset: 5, itemWidth: .bit40)
        
        pr(n1, n2, n3)
    }
    
    func testDemoIntArray() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4]
        
        box.setIntArray(arr, index: 10, offset: 1024 * 64, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
        pr(box.count)
        pr(buf[(1024 * 64)..<box.count])
        
        let result1: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
        pr(result1)
        
        let result2: [UInt8] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
        pr(result2)
        
        let result3: [UInt32] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
        pr(result3)
    }
}
