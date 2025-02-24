import Foundation

extension BinaryStore.Box {
    
    /// Get String Array At Offset
    // data header:
    //   countWidth: array length
    // data:
    //   sizeWidth: string size
    //   [UInt8]: string
    //   ...
    //   ...
    public func getStringArray(_ offset: Int, countWidth: BinaryStore.BitWidth, sizeWidth: BinaryStore.BitWidth, encoding: String.Encoding = .utf8) -> [String] {
        let arrayLen: UInt64 = getInt(offset, itemWidth: countWidth)
        if arrayLen == 0 {
            return []
        }
        var strArr: [String] = []
        strArr.reserveCapacity(Int(arrayLen))
        var off = offset + countWidth.rawValue
        for _ in 0..<arrayLen {
            let wordSize: UInt64 = getInt(off, itemWidth: sizeWidth)
            off += sizeWidth.rawValue
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
