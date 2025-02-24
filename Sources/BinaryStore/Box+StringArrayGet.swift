import Foundation

extension BinaryStore.Box {
    
    /// Get String Array At Offset
    // data header:
    //   countWidth: array length
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    public func getStringArray(offset: Int, arrayWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth = .bit8, encoding: String.Encoding = .utf8) -> [String] {
        let arrayLen: UInt64 = getInt(offset: offset, itemWidth: arrayWidth)
        if arrayLen == 0 {
            return []
        }
        var strArr: [String] = []
        strArr.reserveCapacity(Int(arrayLen))
        var off = offset + arrayWidth.rawValue
        for _ in 0..<arrayLen {
            let wordSize: UInt64 = getInt(offset: off, itemWidth: stringWidth)
            off += stringWidth.rawValue
            if wordSize > 0 {
                if let s = String(bytes: p.pointee[off..<off + Int(wordSize)], encoding: encoding) { // read string from offset(i) to the end(i + wordSize)
                    strArr.append(s)
                }
                off += Int(wordSize)
            } else {
                strArr.append("")
            }
        }
        return strArr
    }
}
