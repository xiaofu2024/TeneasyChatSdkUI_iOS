// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: api/core/chat.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

///分页结构体
public struct Api_Core_Pagination {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///当前页码
  public var page: Int32 = 0

  ///分页大小
  public var pagesize: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// 聊天会话列表
public struct Api_Core_ChatListQueryRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workerID: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// 聊天会话列表
public struct Api_Core_ChatListQueryPageRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var page: Api_Core_Pagination {
    get {return _page ?? Api_Core_Pagination()}
    set {_page = newValue}
  }
  /// Returns true if `page` has been explicitly set.
  public var hasPage: Bool {return self._page != nil}
  /// Clears the value of `page`. Subsequent reads from it will return its default value.
  public mutating func clearPage() {self._page = nil}

  public var workerID: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _page: Api_Core_Pagination? = nil
}

/// 聊天会话列表
public struct Api_Core_ChatListHistoryRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workerID: Int32 = 0

  ///开始查询时间
  public var start: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _start ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_start = newValue}
  }
  /// Returns true if `start` has been explicitly set.
  public var hasStart: Bool {return self._start != nil}
  /// Clears the value of `start`. Subsequent reads from it will return its default value.
  public mutating func clearStart() {self._start = nil}

  ///结束
  public var end: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _end ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_end = newValue}
  }
  /// Returns true if `end` has been explicitly set.
  public var hasEnd: Bool {return self._end != nil}
  /// Clears the value of `end`. Subsequent reads from it will return its default value.
  public mutating func clearEnd() {self._end = nil}

  public var batch: CommonBatch {
    get {return _batch ?? CommonBatch()}
    set {_batch = newValue}
  }
  /// Returns true if `batch` has been explicitly set.
  public var hasBatch: Bool {return self._batch != nil}
  /// Clears the value of `batch`. Subsequent reads from it will return its default value.
  public mutating func clearBatch() {self._batch = nil}

  /// 咨询id
  public var consultID: UInt32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _start: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _end: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _batch: CommonBatch? = nil
}

public struct Api_Core_ChatListHistoryResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chats: [CommonChatItem] = []

  public var batch: CommonBatch {
    get {return _batch ?? CommonBatch()}
    set {_batch = newValue}
  }
  /// Returns true if `batch` has been explicitly set.
  public var hasBatch: Bool {return self._batch != nil}
  /// Clears the value of `batch`. Subsequent reads from it will return its default value.
  public mutating func clearBatch() {self._batch = nil}

  public var total: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _batch: CommonBatch? = nil
}

public struct Api_Core_ChatListQueryResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chats: [CommonChatItem] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_ChatListQueryPageResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///总量
  public var total: Int32 = 0

  public var chats: [CommonChatItem] = []

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

/// 标记已读
public struct Api_Core_ChatMarkReadRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_OrphanResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var workerID: Int32 = 0

  public var nick: String = String()

  public var avatar: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_MarkRepliedRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 = 0

  /// 咨询类型
  public var consultID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_ChatListQueryUserRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var userID: Int32 = 0

  public var registerType: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_OrphanReq {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 = 0

  /// 咨询类型
  public var consultID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Api_Core_Pagination: @unchecked Sendable {}
extension Api_Core_ChatListQueryRequest: @unchecked Sendable {}
extension Api_Core_ChatListQueryPageRequest: @unchecked Sendable {}
extension Api_Core_ChatListHistoryRequest: @unchecked Sendable {}
extension Api_Core_ChatListHistoryResponse: @unchecked Sendable {}
extension Api_Core_ChatListQueryResponse: @unchecked Sendable {}
extension Api_Core_ChatListQueryPageResponse: @unchecked Sendable {}
extension Api_Core_ChatMarkReadRequest: @unchecked Sendable {}
extension Api_Core_OrphanResponse: @unchecked Sendable {}
extension Api_Core_MarkRepliedRequest: @unchecked Sendable {}
extension Api_Core_ChatListQueryUserRequest: @unchecked Sendable {}
extension Api_Core_OrphanReq: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "api.core"

extension Api_Core_Pagination: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".Pagination"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "page"),
    2: .same(proto: "pagesize"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.page) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.pagesize) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.page != 0 {
      try visitor.visitSingularInt32Field(value: self.page, fieldNumber: 1)
    }
    if self.pagesize != 0 {
      try visitor.visitSingularInt32Field(value: self.pagesize, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_Pagination, rhs: Api_Core_Pagination) -> Bool {
    if lhs.page != rhs.page {return false}
    if lhs.pagesize != rhs.pagesize {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListQueryRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListQueryRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "worker_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListQueryRequest, rhs: Api_Core_ChatListQueryRequest) -> Bool {
    if lhs.workerID != rhs.workerID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListQueryPageRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListQueryPageRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "page"),
    2: .standard(proto: "worker_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._page) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._page {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListQueryPageRequest, rhs: Api_Core_ChatListQueryPageRequest) -> Bool {
    if lhs._page != rhs._page {return false}
    if lhs.workerID != rhs.workerID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListHistoryRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListHistoryRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "worker_id"),
    2: .same(proto: "start"),
    3: .same(proto: "end"),
    4: .same(proto: "batch"),
    5: .standard(proto: "consult_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._start) }()
      case 3: try { try decoder.decodeSingularMessageField(value: &self._end) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._batch) }()
      case 5: try { try decoder.decodeSingularUInt32Field(value: &self.consultID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 1)
    }
    try { if let v = self._start {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    try { if let v = self._end {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
    } }()
    try { if let v = self._batch {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    if self.consultID != 0 {
      try visitor.visitSingularUInt32Field(value: self.consultID, fieldNumber: 5)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListHistoryRequest, rhs: Api_Core_ChatListHistoryRequest) -> Bool {
    if lhs.workerID != rhs.workerID {return false}
    if lhs._start != rhs._start {return false}
    if lhs._end != rhs._end {return false}
    if lhs._batch != rhs._batch {return false}
    if lhs.consultID != rhs.consultID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListHistoryResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListHistoryResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "chats"),
    2: .same(proto: "batch"),
    3: .same(proto: "total"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.chats) }()
      case 2: try { try decoder.decodeSingularMessageField(value: &self._batch) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.total) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.chats.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.chats, fieldNumber: 1)
    }
    try { if let v = self._batch {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
    } }()
    if self.total != 0 {
      try visitor.visitSingularInt32Field(value: self.total, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListHistoryResponse, rhs: Api_Core_ChatListHistoryResponse) -> Bool {
    if lhs.chats != rhs.chats {return false}
    if lhs._batch != rhs._batch {return false}
    if lhs.total != rhs.total {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListQueryResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListQueryResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "chats"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeRepeatedMessageField(value: &self.chats) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if !self.chats.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.chats, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListQueryResponse, rhs: Api_Core_ChatListQueryResponse) -> Bool {
    if lhs.chats != rhs.chats {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListQueryPageResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListQueryPageResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "total"),
    2: .same(proto: "chats"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.total) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.chats) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.total != 0 {
      try visitor.visitSingularInt32Field(value: self.total, fieldNumber: 1)
    }
    if !self.chats.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.chats, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListQueryPageResponse, rhs: Api_Core_ChatListQueryPageResponse) -> Bool {
    if lhs.total != rhs.total {return false}
    if lhs.chats != rhs.chats {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatMarkReadRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatMarkReadRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatMarkReadRequest, rhs: Api_Core_ChatMarkReadRequest) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_OrphanResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".OrphanResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "worker_id"),
    2: .same(proto: "nick"),
    3: .same(proto: "avatar"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      case 2: try { try decoder.decodeSingularStringField(value: &self.nick) }()
      case 3: try { try decoder.decodeSingularStringField(value: &self.avatar) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 1)
    }
    if !self.nick.isEmpty {
      try visitor.visitSingularStringField(value: self.nick, fieldNumber: 2)
    }
    if !self.avatar.isEmpty {
      try visitor.visitSingularStringField(value: self.avatar, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_OrphanResponse, rhs: Api_Core_OrphanResponse) -> Bool {
    if lhs.workerID != rhs.workerID {return false}
    if lhs.nick != rhs.nick {return false}
    if lhs.avatar != rhs.avatar {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MarkRepliedRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MarkRepliedRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "consult_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.consultID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.consultID != 0 {
      try visitor.visitSingularInt64Field(value: self.consultID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MarkRepliedRequest, rhs: Api_Core_MarkRepliedRequest) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.consultID != rhs.consultID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_ChatListQueryUserRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatListQueryUserRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "user_id"),
    2: .standard(proto: "register_type"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt32Field(value: &self.userID) }()
      case 2: try { try decoder.decodeSingularInt32Field(value: &self.registerType) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.userID != 0 {
      try visitor.visitSingularInt32Field(value: self.userID, fieldNumber: 1)
    }
    if self.registerType != 0 {
      try visitor.visitSingularInt32Field(value: self.registerType, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_ChatListQueryUserRequest, rhs: Api_Core_ChatListQueryUserRequest) -> Bool {
    if lhs.userID != rhs.userID {return false}
    if lhs.registerType != rhs.registerType {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_OrphanReq: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".OrphanReq"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "consult_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.consultID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.consultID != 0 {
      try visitor.visitSingularInt64Field(value: self.consultID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_OrphanReq, rhs: Api_Core_OrphanReq) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.consultID != rhs.consultID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
