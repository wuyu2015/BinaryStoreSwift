import XCTest
@testable import BinaryStore

final class BoxRangeArrayIndexTests: XCTestCase {
    
    func testInt8() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit8
        
        for _ in 0..<25 {
            var arr: [Range<Int8>] = []
            for _ in 0..<20 {
                let n0:Int8 = Int8.random(in: Int8.min...Int8.max)
                let n1:Int8 = Int8.random(in: n0...Int8.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt8: [Range<Int8>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt8, arr.map { $0.lowerBound..<$0.upperBound})

            let arrInt16: [Range<Int16>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt16, arr.map { Int16(truncatingIfNeeded: $0.lowerBound)..<Int16(truncatingIfNeeded: $0.upperBound)})

            let arrInt32: [Range<Int32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0.lowerBound)..<Int32(truncatingIfNeeded: $0.upperBound)})

            let arrInt64: [Range<Int64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0.lowerBound)..<Int64(truncatingIfNeeded: $0.upperBound)})
        }
    }
    
    func testInt8U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit8

        for _ in 0..<25 {
            var arr: [Range<UInt8>] = []
            for _ in 0..<20 {
                let n0:UInt8 = UInt8.random(in: UInt8.min...UInt8.max)
                let n1:UInt8 = UInt8.random(in: n0...UInt8.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt8U: [Range<UInt8>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt8U, arr.map { $0.lowerBound..<$0.upperBound})
            
            let arrInt16U: [Range<UInt16>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt16U, arr.map { UInt16($0.lowerBound)..<UInt16($0.upperBound)})
            
            let arrInt32U: [Range<UInt32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32($0.lowerBound)..<UInt32($0.upperBound)})
            
            let arrInt64U: [Range<UInt64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0.lowerBound)..<UInt64($0.upperBound)})
        }
    }
    
    func testInt16() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit16
        
        for _ in 0..<25 {
            var arr: [Range<Int16>] = []
            for _ in 0..<20 {
                let n0:Int16 = Int16.random(in: Int16.min...Int16.max)
                let n1:Int16 = Int16.random(in: n0...Int16.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt16: [Range<Int16>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt16, arr.map { $0.lowerBound..<$0.upperBound})
            
            let arrInt32: [Range<Int32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt32, arr.map { Int32(truncatingIfNeeded: $0.lowerBound)..<Int32(truncatingIfNeeded: $0.upperBound)})
            
            let arrInt64: [Range<Int64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0.lowerBound)..<Int64(truncatingIfNeeded: $0.upperBound)})
        }
    }

    func testInt16U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit16

        for _ in 0..<25 {
            var arr: [Range<UInt16>] = []
            for _ in 0..<20 {
                let n0:UInt16 = UInt16.random(in: UInt16.min...UInt16.max)
                let n1:UInt16 = UInt16.random(in: n0...UInt16.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt16U: [Range<UInt16>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt16U, arr.map { $0.lowerBound..<$0.upperBound})
            
            let arrInt32U: [Range<UInt32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt32U, arr.map { UInt32($0.lowerBound)..<UInt32($0.upperBound)})
            
            let arrInt64U: [Range<UInt64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0.lowerBound)..<UInt64($0.upperBound)})
        }
    }
    
    func testInt32() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit32
        
        for _ in 0..<25 {
            var arr: [Range<Int32>] = []
            for _ in 0..<20 {
                let n0:Int32 = Int32.random(in: Int32.min...Int32.max)
                let n1:Int32 = Int32.random(in: n0...Int32.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt32: [Range<Int32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt32, arr.map { $0.lowerBound..<$0.upperBound})
            
            let arrInt64: [Range<Int64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth, sign: .signed)
            XCTAssertEqual(arrInt64, arr.map { Int64(truncatingIfNeeded: $0.lowerBound)..<Int64(truncatingIfNeeded: $0.upperBound)})
        }
    }

    func testInt32U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit32

        for _ in 0..<25 {
            var arr: [Range<UInt32>] = []
            for _ in 0..<20 {
                let n0:UInt32 = UInt32.random(in: UInt32.min...UInt32.max)
                let n1:UInt32 = UInt32.random(in: n0...UInt32.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt32U: [Range<UInt32>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt32U, arr.map { $0.lowerBound..<$0.upperBound})
            
            let arrInt64U: [Range<UInt64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt64U, arr.map { UInt64($0.lowerBound)..<UInt64($0.upperBound)})
        }
    }
    
    func testInt64() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit64
        
        for _ in 0..<25 {
            var arr: [Range<Int64>] = []
            for _ in 0..<20 {
                let n0:Int64 = Int64.random(in: Int64.min...Int64.max)
                let n1:Int64 = Int64.random(in: n0...Int64.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt64: [Range<Int64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt64, arr.map { $0.lowerBound..<$0.upperBound})
        }
    }

    func testInt64U() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        let offsetWidth = BinaryStore.BitWidth.bit32
        let byteWidth = BinaryStore.BitWidth.bit32
        let rangeWidth = BinaryStore.BitWidth.bit64

        for _ in 0..<25 {
            var arr: [Range<UInt64>] = []
            for _ in 0..<20 {
                let n0:UInt64 = UInt64.random(in: UInt64.min...UInt64.max)
                let n1:UInt64 = UInt64.random(in: n0...UInt64.max)
                arr.append(n0..<n1)
            }
            let index = Int.random(in: 0...1024)
            let indexSz = offsetWidth.rawValue + byteWidth.rawValue
            let off = Int.random(in: index + indexSz...index + indexSz + 1024)
            let sz = box.setRangeArray(arr, index: index, offset: off, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            XCTAssertEqual(sz, arr.count * rangeWidth.rawValue * 2)
            
            let arrInt64U: [Range<UInt64>] = box.getRangeArray(index: index, offsetWidth: offsetWidth, byteWidth: byteWidth, rangeWidth: rangeWidth)
            XCTAssertEqual(arrInt64U, arr.map { $0.lowerBound..<$0.upperBound})
        }
    }
}

