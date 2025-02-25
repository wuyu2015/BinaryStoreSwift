import Foundation

extension BinaryStore.Box {
    
    /// Get String At Offset
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    public func getString(offset: Int, stringWidth: BinaryStore.BitWidth = .bit8, encoding: String.Encoding = .utf8) -> String {
        let sz: Int = getInt(offset: offset, intWidth: stringWidth)
        if sz == 0 {
            return ""
        }
        let off = offset + stringWidth.rawValue
        return String(bytes: p.pointee[off..<off + sz], encoding: encoding) ?? ""
    }
}
