import Foundation

extension BinaryStore.Box {
    
    /// Get String At Offset
    // data:
    //   type: size of string
    //   [UInt8]: string
    public func getString(_ offset: Int, sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> String {
        let sz: UInt64 = getInt(offset, itemWidth: sizeWidth) // 如果使用 Int 取值可能得到负数！
        if sz == 0 {
            return ""
        }
        let off = offset + sizeWidth.rawValue
        return String(bytes: p.pointee[off..<off + Int(sz)], encoding: encoding) ?? ""
    }
}
