import XCTest
import XCTestDelayPrinter
@testable import BinaryStore

final class DemoTests: XCTestCase {
    func testDemoInt() {
        var buf: [UInt8] = []
        let box = BinaryStore.Box(bytes: &buf)
        
        box.setInt(10086, offset: 0, itemWidth: .bit16)
        box.setInt(65536, offset: 2, itemWidth: .bit24)
        box.setInt(13888888888, offset: 5, itemWidth: .bit40)
        pr(box.count)
        pr(buf)
    }
}
