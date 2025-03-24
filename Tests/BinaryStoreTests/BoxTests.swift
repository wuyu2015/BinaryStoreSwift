import XCTest
@testable import BinaryStore

final class BoxTests: XCTestCase {
    func testInit() {
        var arr: [UInt8] = [1, 2, 3, 4]
        var box = BinaryStore.Box(bytes: &arr)
        
        box[0] = 100
        XCTAssertEqual(arr, box.p.pointee)
        print(arr)
        print(box.p.pointee)
        
        arr[1] = 200
        XCTAssertEqual(arr, box.p.pointee)
        print(arr)
        print(box.p.pointee)
    }
    
    func testInit2() {
        var data = Data([1, 2, 3, 4])
        var box = BinaryStore.Box(bytes: &data)
        
        box[0] = 100
        XCTAssertEqual(data, box.p.pointee)
        print(data.withUnsafeBytes { Array($0) })
        print(box.p.pointee.withUnsafeBytes { Array($0) })
        
        data[1] = 200
        XCTAssertEqual(data, box.p.pointee)
        print(data.withUnsafeBytes { Array($0) })
        print(box.p.pointee.withUnsafeBytes { Array($0) })
    }
}
