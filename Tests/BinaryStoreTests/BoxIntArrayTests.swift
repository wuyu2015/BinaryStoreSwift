import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class BoxIntArrayTests: XCTestCase {
    
    func testInt8() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            let arr = [Int8](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                Int8.random(in: Int8.min...Int8.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { $0 })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(UInt8(truncatingIfNeeded: $0)) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32(UInt8(truncatingIfNeeded: $0)) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64(UInt8(truncatingIfNeeded: $0)) })
        }
    }
    
    func testInt8U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit8

        for _ in 0..<25 {
            let arr = [UInt8](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                UInt8.random(in: UInt8.min...UInt8.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { $0 })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(Int8(truncatingIfNeeded: $0)) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16($0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(Int8(truncatingIfNeeded: $0)) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32($0) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(Int8(truncatingIfNeeded: $0)) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0) })
        }
    }
    
    func testInt16() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            let arr = [Int16](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                Int16.random(in: Int16.min...Int16.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { $0 })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(truncatingIfNeeded: $0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32(UInt16(truncatingIfNeeded: $0)) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64(UInt16(truncatingIfNeeded: $0)) })
        }
    }

    func testInt16U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit16

        for _ in 0..<25 {
            let arr = [UInt16](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                UInt16.random(in: UInt16.min...UInt16.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { $0 })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(Int16(truncatingIfNeeded: $0)) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32($0) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(Int16(truncatingIfNeeded: $0)) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0) })
        }
    }
    
    func testInt32() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            let arr = [Int32](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                Int32.random(in: Int32.min...Int32.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(truncatingIfNeeded: $0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { $0 })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32(UInt32(truncatingIfNeeded: $0)) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64(UInt32(truncatingIfNeeded: $0)) })
        }
    }

    func testInt32U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit32

        for _ in 0..<25 {
            let arr = [UInt32](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                UInt32.random(in: UInt32.min...UInt32.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(truncatingIfNeeded: $0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { $0 })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(Int32(truncatingIfNeeded: $0)) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0) })
        }
    }
    
    func testInt64() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            let arr = [Int64](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                Int64.random(in: Int64.min...Int64.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(truncatingIfNeeded: $0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32(truncatingIfNeeded: $0) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { $0 })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64(truncatingIfNeeded: $0) })
        }
    }

    func testInt64U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let itemWidth = BinaryStore.BitWidth.bit64

        for _ in 0..<25 {
            let arr = [UInt64](repeating: 0, count: Int.random(in: 0...20)).map { _ in
                UInt64.random(in: UInt64.min...UInt64.max)
            }
            let off = Int.random(in: 0...1024)
            let sz = box.setIntArray(arr, offset: off, intWidth: itemWidth)
            XCTAssertEqual(sz, arr.count * itemWidth.rawValue)
            
            let arrInt8: [Int8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8, arr.map { Int8(truncatingIfNeeded: $0) })
            let arrInt8U: [UInt8]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt8U, arr.map { UInt8(truncatingIfNeeded: $0) })
            
            let arrInt16: [Int16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0) })
            let arrInt16U: [UInt16]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16(truncatingIfNeeded: $0) })
            
            let arrInt32: [Int32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0) })
            let arrInt32U: [UInt32]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32(truncatingIfNeeded: $0) })
            
            let arrInt64: [Int64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0) })
            let arrInt64U: [UInt64]  = box.getIntArray(off..<off + sz, intWidth: itemWidth)
            XCTAssertEqual(arrInt64U, arr.map { $0 })
        }
    }
}
