import Foundation

extension BinaryStore.Box {
    
    // MARK: Get String Array At Index
    
    // header:
    //   offsetWidth: offset
    //   byteWidth: count of data bytes
    public func getStringArray(index: Int, offsetWidth: BinaryStore.BitWidth, byteWidth: BinaryStore.BitWidth, arrayWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> [String] {
        let sz: Int = getInt(offset: index + offsetWidth.rawValue, intWidth: byteWidth, sign: .unsigned)
        if sz == 0 {
            return []
        }
        let off: Int = getInt(offset: index, intWidth: offsetWidth, sign: .unsigned)
        return getStringArray(offset: off, arrayWidth: arrayWidth, stringWidth: stringWidth, encoding: encoding)
    }
    
    
    // MARK: Set String Array At Index
    
    // head 1:
    //   offsetWidth: offset
    //   byteWidth: sz1
    // head 2:
    //   offsetWidth: offset
    //   byteWidth: sz2
    // data 1 header:
    //   countWidth: array length
    // data 1:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    // data 2:
    //   [offsetWidth] offsets
    @discardableResult
    public func setStringArray(_ strArr: [String], index: Int, index0: Int = 0, offset: Int, offsetWidth: BinaryStore.BitWidth, byteWidth: BinaryStore.BitWidth, arrayWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding, withArrayIndex: Bool) -> Int {
        // set string array at offset
        let offsets = setStringArray(strArr, offset: offset, offset0: index0, arrayWidth: arrayWidth, stringWidth: stringWidth, encoding: encoding)
        let sz1 = offsets.isEmpty ? 0 : Int(offsets.last!) + index0 - offset
        // set offset in head 1
        setInt(sz1 == 0 ? 0 : offset - index0, offset: index, intWidth: offsetWidth)
        // set size in head 1
        setInt(sz1, offset: index + offsetWidth.rawValue, intWidth: byteWidth)
        if !withArrayIndex {
            return sz1
        }
        // set offsets array in head 2
        let sz2 = setIntArray(offsets, index: index + offsetWidth.rawValue + stringWidth.rawValue, offset: offset + sz1, offsetWidth: offsetWidth, byteWidth: byteWidth, intWidth: offsetWidth)
        // return the sum of string array bytes and offsets array bytes
        return sz1 + sz2
    }
    
    // MARK: To String Array
    
    // data header:
    //   countWidth: array length
    // data:
    //   stringWidth: capacity of string
    //   [UInt8]: string data
    //   ...
    //   ...
    public func toStringArray(arrayWidth: BinaryStore.BitWidth, stringWidth: BinaryStore.BitWidth, encoding: String.Encoding) -> [String] {
        return getStringArray(offset: 0, arrayWidth: arrayWidth, stringWidth: stringWidth, encoding: encoding)
    }
}
