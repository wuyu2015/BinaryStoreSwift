extension BinaryStore.Box {
    
    
    // MARK: Set Binary Plist At Offset
    
    // data:
    //   [UInt8]: binary plist data
    // return: binary plist byte size
    public func setBinaryPlist<T: Encodable>(_ value: T, offset: Int) throws -> Int {
        let data = try BinaryStore.binaryPlistEncoder.encode(value)
        
        let sz = offset + data.count
        if sz > p.pointee.count {
            p.pointee.append(contentsOf: Array(repeating: 0, count: sz - p.pointee.count))
        }
        
        var off = offset
        for byte in data {
            p.pointee[off] = byte
            off += 1
        }
        return data.count
    }
    
    // MARK: Set Binary Plist At Index
    
    // head:
    //   offsetType: offset
    //   sizeType: size
    // data:
    //   [UInt8]: binary plist data
    // return: binary plist byte size
    public func setBinaryPlist<T: Encodable>(_ value: T, index: Int, offset: Int, offsetType: BinaryStore.BitWidth, sizeType: BinaryStore.BitWidth) throws -> Int {
        // set binary plist at offset
        let sz = try setBinaryPlist(value, offset: offset)
        // set offset in head
        setInt(sz == 0 ? UInt32(0) : UInt32(offset), offset: index, intWidth: offsetType)
        // set size in head
        setInt(UInt32(sz), offset: index + offsetType.rawValue, intWidth: sizeType)
        // return the binary plist byte size
        return sz
    }
}
