import Foundation

extension BinaryStore.Box {
    
    /// Get String At Offset
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    public func getString(offset: Int, stringWidth: BinaryStore.BitWidth = .bit8, encoding: String.Encoding = .utf8) -> String {
        let sz: UInt64 = getInt(offset: offset, itemWidth: stringWidth) // 如果使用 Int 取值可能得到负数！
        if sz == 0 {
            return ""
        }
        let off = offset + stringWidth.rawValue
        return String(bytes: p.pointee[off..<off + Int(sz)], encoding: encoding) ?? ""
    }
}
