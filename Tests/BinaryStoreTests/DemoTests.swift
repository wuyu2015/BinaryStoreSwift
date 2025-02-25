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
        
        pr(buf)
        
        let sz: Int = box.getInt(offset: 100)
        pr(sz)
        
        let s1 = box.getString(index: 0)
        pr(s1)
        
        let s2 = box.getString(offset: 100)
        pr(s2)
    }
    
    func testDemoStringArray() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let arr = ["Hello world!", "a", "ab", "abc"]

        // 储存字符串数组
        box.setStringArray(arr, index: 0, offset: 100, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8, withArrayIndex: true)
        
        // 通过索引（0）取出字符串数组
        let result1 = box.getStringArray(index: 0, offsetWidth: .bit16, byteWidth: .bit16, arrayWidth: .bit8)

        // 输出：["Hello world!", "a", "ab", "abc"]
        pr(result1)

        // 或直接通过地址（100）取出字符串数组
        let result2 = box.getStringArray(offset: 100, arrayWidth: .bit8)

        // 输出：["Hello world!", "a", "ab", "abc"]
        pr(result2)
    }
    
    func testRange() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let range = 0..<128

        // 存储 range
        box.setRange(range, offset: 0, rangeWidth: .bit16)
        
        // 直接通过偏移值（0）取出 range
        let result: Range<Int> = box.getRange(offset: 0, rangeWidth: .bit16)

        // 输出:
        pr(result)
    }
    
    func testRangeArray() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        let rangeArr: [Range<Int>] = [
            -128..<128,
            256..<512,
            1024..<4096
        ]

        // 存储 range 数组
        box.setRangeArray(rangeArr, index: 0, offset: 100, rangeWidth: .bit16)
        
        // 通过索引取出 range 数组
        let result: [Range<Int>] = box.getRangeArray(index: 0, rangeWidth: .bit16, sign: .signed)

        // 输出:
        pr(result)
    }
}
