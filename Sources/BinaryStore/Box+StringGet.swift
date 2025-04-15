import Foundation

extension BinaryStore.Box {
    
    /// Get String At Offset
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    public func getString(offset: Int, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> String {
        let sz: Int = getInt(offset: offset, intWidth: stringWidth, sign: .unsigned)
        if sz == 0 {
            return ""
        }
        let off = offset + stringWidth.rawValue
        return String(bytes: p.pointee[off..<off + sz], encoding: encoding) ?? ""
    }
}
