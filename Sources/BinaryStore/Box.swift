extension BinaryStore {
    public struct Box<C: MutableCollection & RandomAccessCollection & RangeReplaceableCollection> where C.Index == Int, C.Element == UInt8 {

        public var p: UnsafeMutablePointer<C>

        public init(bytes: UnsafeMutablePointer<C>) {
            p = bytes
        }
    }
}
