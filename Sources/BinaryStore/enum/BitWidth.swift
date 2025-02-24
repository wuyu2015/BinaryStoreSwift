extension BinaryStore {
    public enum BitWidth: Int {
        case bit8 = 1
        case bit16
        case bit24 // 3 bytes
        case bit32
        case bit40 // 5 bytes
        case bit48 // 6 bytes
        case bit56 // 7 bytes
        case bit64
        
        public static let min: Int = 1
        public static let max: Int = 8
    }
}
