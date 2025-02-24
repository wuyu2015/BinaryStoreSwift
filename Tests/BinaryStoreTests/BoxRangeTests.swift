import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class BoxRangeTests: XCTestCase {
    
    func testInt8() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            let n = Int8.random(in: Int8.min...Int8.max)
            let m = Int8.random(in: n...Int8.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result8: Range<Int8> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result8, n..<m)

            let result16: Range<Int16> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n)..<Int16(truncatingIfNeeded: m))

            let result32: Range<Int32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n)..<Int32(truncatingIfNeeded: m))

            let result64: Range<Int64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n)..<Int64(truncatingIfNeeded: m))

            let result: Range<Int> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n)..<Int(truncatingIfNeeded: m))
        }
    }
    
    func testInt8u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            let n = UInt8.random(in: UInt8.min...UInt8.max)
            let m = UInt8.random(in: n...UInt8.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result8u: Range<UInt8> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result8u, n..<m)
            
            let result16u: Range<UInt16> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result16u, UInt16(n)..<UInt16(m))
            
            let result32u: Range<UInt32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32u, UInt32(n)..<UInt32(m))
            
            let result64u: Range<UInt64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64u, UInt64(n)..<UInt64(m))
            
            let resultu: Range<UInt> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(resultu, UInt(n)..<UInt(m))
        }
    }
    
    func testInt16() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            let n = Int16.random(in: Int16.min...Int16.max)
            let m = Int16.random(in: n...Int16.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result16: Range<Int16> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result16, n..<m)
            
            let result32: Range<Int32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n)..<Int32(truncatingIfNeeded: m))
            
            let result64: Range<Int64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n)..<Int64(truncatingIfNeeded: m))
            
            let result: Range<Int> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n)..<Int(truncatingIfNeeded: m))
        }
    }

    func testInt16u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            let n = UInt16.random(in: UInt16.min...UInt16.max)
            let m = UInt16.random(in: n...UInt16.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result16u: Range<UInt16> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result16u, n..<m)
            
            let result32u: Range<UInt32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32u, UInt32(n)..<UInt32(m))
            
            let result64u: Range<UInt64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64u, UInt64(n)..<UInt64(m))
            
            let resultu: Range<UInt> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(resultu, UInt(n)..<UInt(m))
        }
    }
    
    func testInt32() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            let n = Int32.random(in: Int32.min...Int32.max)
            let m = Int32.random(in: n...Int32.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result32: Range<Int32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32, n..<m)
            
            let result64: Range<Int64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n)..<Int64(truncatingIfNeeded: m))
            
            let result: Range<Int> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n)..<Int(truncatingIfNeeded: m))
        }
    }

    func testInt32u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            let n = UInt32.random(in: UInt32.min...UInt32.max)
            let m = UInt32.random(in: n...UInt32.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result32u: Range<UInt32> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result32u, n..<m)
            
            let result64u: Range<UInt64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64u, UInt64(n)..<UInt64(m))
            
            let resultu: Range<UInt> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(resultu, UInt(n)..<UInt(m))
        }
    }
    
    func testInt64() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = Int64.random(in: Int64.min...Int64.max)
            let m = Int64.random(in: n...Int64.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result64: Range<Int64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64, n..<m)
            
            let result: Range<Int> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n)..<Int(truncatingIfNeeded: m))
        }
    }

    func testInt64u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = UInt64.random(in: UInt64.min...UInt64.max)
            let m = UInt64.random(in: n...UInt64.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result64u: Range<UInt64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64u, n..<m)
            
            let resultu: Range<UInt> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(resultu, UInt(n)..<UInt(m))
        }
    }
    
    func testInt() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = Int.random(in: Int.min...Int.max)
            let m = Int.random(in: n...Int.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result64: Range<Int64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n)..<Int64(truncatingIfNeeded: m))
            
            let result: Range<Int> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result, n..<m)
        }
    }

    func testIntU() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = UInt.random(in: UInt.min...UInt.max)
            let m = UInt.random(in: n...UInt.max)
            let range = n..<m
            
            let off = Int.random(in: 0...100)
            let sz = box.setRange(range, offset: off, itemWidth: itemWidth)
            XCTAssertEqual(sz, itemWidth.rawValue * 2)
            
            let result64u: Range<UInt64> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(result64u, UInt64(n)..<UInt64(m))
            
            let resultu: Range<UInt> = box.getRange(off, itemWidth: itemWidth)
            XCTAssertEqual(resultu, n..<m)
        }
    }
}
