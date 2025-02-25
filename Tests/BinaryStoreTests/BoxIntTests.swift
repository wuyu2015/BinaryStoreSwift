import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class BoxIntTests: XCTestCase {
    
    func testInt8() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            let n = Int8.random(in: Int8.min...Int8.max)
            let n1 = UInt8(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, n)
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, n1)
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(n1))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(n1))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n1))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n1))
        }
    }
    
    func testInt8u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            let n = UInt8.random(in: UInt8.min...UInt8.max)
            let n1 = Int8(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, n1)
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, n)
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(n))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(n))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(n))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, Int64(n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, Int(n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n))
        }
    }
    
    func testInt16() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            let n = Int16.random(in: Int16.min...Int16.max)
            let n1 = UInt16(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, n)
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, n1)
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result32, Int32(n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(n1))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result64, Int64(n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n1))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result, Int(n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n1))
        }
    }

    func testInt16u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            let n = UInt16.random(in: UInt16.min...UInt16.max)
            let n1 = Int16(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n1))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, n1)
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, n)
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(n))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, Int64(n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, Int(n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n))
        }
    }
    
    func testInt32() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            let n = Int32.random(in: Int32.min...Int32.max)
            let n1 = UInt32(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n1))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, n)
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, n1)
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result64, Int64(n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n1))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth, sign: .signed)
            XCTAssertEqual(result, Int(n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n1))
        }
    }

    func testInt32u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            let n = UInt32.random(in: UInt32.min...UInt32.max)
            let n1 = Int32(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n1))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n1))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, n1)
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, n)
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, Int64(n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, Int(n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n))
        }
    }
    
    func testInt64() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = Int64.random(in: Int64.min...Int64.max)
            let n1 = UInt64(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n1))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(truncatingIfNeeded: n1))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, n)
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, n1)
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, Int(truncatingIfNeeded: n))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n1))
        }
    }

    func testInt64u() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = UInt64.random(in: UInt64.min...UInt64.max)
            let n1 = Int64(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n1))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n1))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n1))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(truncatingIfNeeded: n))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, n1)
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, n)
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, Int(n1))
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, UInt(n))
        }
    }
    
    func testInt() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = Int.random(in: Int.min...Int.max)
            let n1 = UInt(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n1))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(truncatingIfNeeded: n1))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, Int64(truncatingIfNeeded: n))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(truncatingIfNeeded: n1))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, n)
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, n1)
        }
    }

    func testIntU() {
        var buf = randomBuf(count: 100)
        let box = BinaryStore.Box(bytes: &buf)
        let intWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let n = UInt.random(in: UInt.min...UInt.max)
            let n1 = Int(truncatingIfNeeded: n)
            let off = Int.random(in: 0...100)
            box.setInt(n, offset: off, intWidth: intWidth)
            
            let result8: Int8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8, Int8(truncatingIfNeeded: n1))
            let result8u: UInt8 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result8u, UInt8(truncatingIfNeeded: n))
            
            let result16: Int16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16, Int16(truncatingIfNeeded: n1))
            let result16u: UInt16 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result16u, UInt16(truncatingIfNeeded: n))
            
            let result32: Int32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32, Int32(truncatingIfNeeded: n1))
            let result32u: UInt32 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result32u, UInt32(truncatingIfNeeded: n))
            
            let result64: Int64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64, Int64(n1))
            let result64u: UInt64 = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result64u, UInt64(n))
            
            let result: Int = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(result, n1)
            let resultu: UInt = box.getInt(offset: off, intWidth: intWidth)
            XCTAssertEqual(resultu, n)
        }
    }
}
