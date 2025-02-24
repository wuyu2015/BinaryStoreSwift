import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class DemoTests: XCTestCase {
    func testDemoInt() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        box.setInt(123, offset: 0)
        box.setInt(65535, offset: 1, intWidth: .bit16)
        box.setInt(65536, offset: 3, intWidth: .bit24)
        box.setInt(13888888888, offset: 6, intWidth: .bit40)
        pr(box.count)
        pr(buf)
        
        let n1: Int = box.getInt(offset: 0)
        let n2: UInt16 = box.getInt(offset: 1, intWidth: .bit16)
        let n3: UInt32 = box.getInt(offset: 3, intWidth: .bit24)
        let n4: Int = box.getInt(offset: 6, intWidth: .bit40)
        
        pr(n1, n2, n3, n4)
    }
    
    func testDemoIntArray() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4]
        
        box.setIntArray(arr, index: 10, offset: 1024 * 64, offsetWidth: .bit32, byteWidth: .bit8, intWidth: .bit8)
        pr(box.count)
        pr(buf[(1024 * 64)..<box.count])
        
        let result1: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, byteWidth: .bit8, intWidth: .bit8)
        pr(result1)
        
        let result2: [UInt8] = box.getIntArray(index: 10, offsetWidth: .bit32, byteWidth: .bit8, intWidth: .bit8)
        pr(result2)
        
        let result3: [UInt32] = box.getIntArray(index: 10, offsetWidth: .bit32, byteWidth: .bit8, intWidth: .bit8)
        pr(result3)
    }
    
    func testDemoString() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let s = "Hello world!"
        
        box.setString(s, index: 0, offset: 100)
        
        let sz: Int = box.getInt(offset: 100)
        pr(sz)
        
        let s1 = box.getString(index: 0)
        pr(s1)
        
        let s2 = box.getString(offset: 100)
        pr(s2)
    }
}
