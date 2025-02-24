# BinaryStore  

`BinaryStore` is a Swift Package designed for creating custom binary data files, focusing on storage efficiency. It allows developers to flexibly construct and manipulate binary file formats. In addition to the standard 8-bit, 16-bit, 32-bit, and 64-bit integer types, BinaryStore also supports non-standard integer lengths such as 24-bit, 40-bit, 48-bit, and 56-bit for more efficient storage.

## Getting Started  

### Initializing `BinaryStore.box`  

```swift
import BinaryStore

var buf: [UInt8] = []
let box = BinaryStore.box(&buf)
```

### Integer Storage  

```swift
// Store the number 10086 (a telecom service number) using 2 bytes
box.setInt(10086, offset: 0, itemWidth: .bit16)

// Store 65536 using 3 bytes
box.setInt(65536, offset: 2, itemWidth: .bit24)

// Store a mainland China phone number using 5 bytes
box.setInt(13888888888, offset: 5, itemWidth: .bit40)

// A total of 10 bytes are used
print(box.count) // Output: 10

// Read as Int
let n1 = box.getInt(0, itemWidth: .bit16)
let n2 = box.getInt(2, itemWidth: .bit24)
let n3 = box.getInt(5, itemWidth: .bit40)
```

### Integer Arrays  

```swift
// Define an array of type [Int8]
let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4] 

// Write the array starting at offset 64K, with the index stored at position 10
box.setIntArray(arr, index: 10, offset: 1024 * 64, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)

// Retrieve it as [Int], using only the index
// Note: Ensuring matching width types is crucial. Using different widths creatively can make unauthorized parsing of your binary files difficult.
let result: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)

// Or retrieve it as [Int8]
let result8: [Int8] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
```

### Strings  

```swift
let s = "Hello world!"

// Write the string starting at offset 64K, storing the index at position 0
box.setString(s, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit8)

// Retrieve the string using the index
_ = getString(index: 0, offsetWidth: .bit32, sizeWidth: .bit8)

// Or retrieve it using the offset directly at 128K
_ = getString(64 * 1024, 100, sizeWidth: .bit8)
```

### String Arrays  

```swift
let arr = ["a", "b", "c", "Hello world!"]

// Write the string array at offset 64K, storing the index at position 0
box.setStringArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit24, countWidth: .bit24)

// Retrieve the string array using the index
_ = getStringArray(index: 0, offsetWidth: .bit32, sizeWidth: .bit24, countWidth: .bit24)

// Or retrieve it directly using the offset at 64K
_ = getString(64 * 1024, 100, countWidth: .bit24, sizeWidth: .bit8)
```

### Ranges  

```swift
let range = 0..<128

// Store the range
box.setRangeArray(range, index: 0, offset: 64 * 1024, itemWidth: .bit8)

// Retrieve the range using the index
_ = setRange(index: 0, offsetWidth: .bit32, itemWidth: .bit8)

// Retrieve the range directly using the offset
_ = getRange(64 * 1024, 100, itemWidth: .bit8)
```

### Range Arrays  

```swift
let arr: [Range<Int>] = [
    0..<128,
    128..<256,
    256..<512,
]

// Store the range array
box.setRangeArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit32, itemWidth: .bit32)

// Retrieve the range array using the index
let result: [Range<Int>] = getRangeArray(index: 0, offsetWidth: .bit32, sizeWidth: .bit32, itemWidth: .bit32)
```

## Installation  

To integrate `BinaryStore` into your Swift project, add the following to your `Package.swift` file:  

```swift
dependencies: [
    .package(url: "https://github.com/wuyu2015/BinaryStoreSwift.git", from: "0.0.1")
]
```

### Or Install via Xcode  

1. Open your Xcode project.  
2. Go to **File** -> **Swift Packages** -> **Add Package Dependency**.  
3. Enter the GitHub repository URL: `https://github.com/wuyu2015/BinaryStoreSwift.git`.  
4. Choose the desired version (e.g., `0.0.1`) and complete the installation.  

You can now use `BinaryStore` in your project.

## License  

This project is licensed under the MIT License.

---

# BinaryStore  

`BinaryStore` 是一个 Swift Package，专为创建自定义二进制数据文件而设计，重点在于提高存储效率。它允许开发者灵活地构建和操作二进制文件格式。除了标准的 8 位、16 位、32 位、64 位整型之外，BinaryStore 还支持 24 位、40 位、48 位和 56 位的非主流整型，以便更高效地存储数据。  

## 快速开始  

### 初始化 `BinaryStore.box`  

```swift
import BinaryStore

var buf: [UInt8] = []
let box = BinaryStore.box(&buf)
```

### 整型存储  

```swift
// 使用 2 字节存储 10086 这个奸商电话号码
box.setInt(10086, offset: 0, itemWidth: .bit16)

// 使用 3 字节存储 65536
box.setInt(65536, offset: 2, itemWidth: .bit24)

// 使用 5 字节存储中国大陆手机号码
box.setInt(13888888888, offset: 5, itemWidth: .bit40)

// 总共使用 10 字节
print(box.count) // 输出：10

// 读取整数
let n1 = box.getInt(0, itemWidth: .bit16)
let n2 = box.getInt(2, itemWidth: .bit24)
let n3 = box.getInt(5, itemWidth: .bit40)
```

### 整型数组  

```swift
// 定义 [Int8] 类型的数组
let arr: [Int8] = [1, 2, 3, 4, -1, -2, -3, -4]  

// 在 64K 偏移处写入数组数据，索引存储在位置 10
box.setIntArray(arr, index: 10, offset: 1024 * 64, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)

// 只使用索引即可重新获取数据
// 注意：确保宽度匹配至关重要，灵活使用不同宽度类型会让非法解析你二进制文件的人头疼
let result: [Int] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)

// 或者使用 [Int8] 读取
let result8: [Int8] = box.getIntArray(index: 10, offsetWidth: .bit32, sizeWidth: .bit8, itemWidth: .bit8)
```

### 字符串  

```swift
let s = "Hello world!"

// 在 64K 偏移处写入字符串，索引存储在 0 位置
box.setString(s, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit8)

// 通过索引取出字符串
_ = getString(index: 0, offsetWidth: .bit32, sizeWidth: .bit8)

// 或者直接通过偏移值（128K 处）取出字符串
_ = getString(64 * 1024, 100, sizeWidth: .bit8)
```

### 字符串数组  

```swift
let arr = ["a", "b", "c", "Hello world!"]

// 在 64K 偏移处写入字符串数组，索引存储在 0 位置
box.setStringArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit24, countWidth: .bit24)

// 通过索引取出字符串数组
_ = getStringArray(index: 0, offsetWidth: .bit32, sizeWidth: .bit24, countWidth: .bit24)

// 或者直接通过偏移值（64K 处）取出字符串数组
_ = getString(64 * 1024, 100, countWidth: .bit24, sizeWidth: .bit8)
```

### Range  

```swift
let range = 0..<128

// 存储 range
box.setRangeArray(range, index: 0, offset: 64 * 1024, itemWidth: .bit8)

// 通过索引取出 range
_ = setRange(index: 0, offsetWidth: .bit32, itemWidth: .bit8)

// 直接通过偏移值取出 range
_ = getRange(64 * 1024, 100, itemWidth: .bit8)
```

### Range 数组  

```swift
let arr: [Range<Int>] = [
    0..<128,
    128..<256,
    256..<512,
]

// 存储 range 数组
box.setRangeArray(arr, index: 0, offset: 64 * 1024, offsetWidth: .bit32, sizeWidth: .bit32, itemWidth: .bit32)

// 通过索引取出 range 数组
let result: [Range<Int>] = getRangeArray(index: 0, offsetWidth: .bit32, sizeWidth: .bit32, itemWidth: .bit32)
```

## 安装  

要将 `BinaryStore` 集成到你的 Swift 项目中，请在 `Package.swift` 文件中添加以下内容：  

```swift
dependencies: [
    .package(url: "https://github.com/wuyu2015/BinaryStoreSwift.git", from: "0.0.1")
]
```

### 或使用 Xcode 安装  

1. 打开你的 Xcode 项目。  
2. 依次选择 **File** -> **Swift Packages** -> **Add Package Dependency**。  
3. 在弹出的窗口中输入 GitHub 仓库地址：`https://github.com/wuyu2015/BinaryStoreSwift.git`。  
4. 选择所需的版本（例如 `0.0.1`）并完成安装。  

这样，你就可以在项目中使用 `BinaryStore` 了。

## 许可证  

本项目采用 MIT 许可证。
