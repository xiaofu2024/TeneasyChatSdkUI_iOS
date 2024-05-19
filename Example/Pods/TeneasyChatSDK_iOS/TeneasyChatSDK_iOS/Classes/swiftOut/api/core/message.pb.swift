// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: api/core/message.proto
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

public struct Api_Core_MessageSyncRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 会话id 商户客服需要指定 客户可以省略
  public var chatID: Int64 = 0

  /// 客户端已知的最早消息id，服务会发送更早的消息给客户端
  public var msgID: Int64 = 0

  /// 加载多少条消息
  public var count: Int32 = 0

  /// 结果包括msg_id这条信息
  public var withLastOne: Bool = false

  /// 指定下级workerId
  public var workerID: Int32 = 0

  /// 咨询id
  public var consultID: UInt32 = 0

  /// 用户id
  public var userID: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_MessageSyncResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 请求信息
  public var request: Api_Core_MessageSyncRequest {
    get {return _request ?? Api_Core_MessageSyncRequest()}
    set {_request = newValue}
  }
  /// Returns true if `request` has been explicitly set.
  public var hasRequest: Bool {return self._request != nil}
  /// Clears the value of `request`. Subsequent reads from it will return its default value.
  public mutating func clearRequest() {self._request = nil}

  /// 历史消息
  public var list: [CommonMessage] = []

  /// 已过滤最早id, 分页时传递给下一页
  public var lastMsgID: Int64 = 0

  public var nick: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _request: Api_Core_MessageSyncRequest? = nil
}

public struct Api_Core_MessageSyncV2Request {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 会话id 商户客服需要指定 客户可以省略
  public var chatID: Int64 = 0

  /// 客户端已知的最早消息id，服务会发送更早的消息给客户端
  public var msgID: Int64 = 0

  /// 加载多少条消息
  public var count: Int32 = 0

  /// 结果包括msg_id这条信息
  public var withLastOne: Bool = false

  /// 指定下级workerId
  public var workerID: Int32 = 0

  /// 咨询id
  public var consultID: UInt32 = 0

  /// 用户id
  public var userID: Int32 = 0

  /// 开始毫秒时间戳
  public var startAt: Int64 = 0

  /// 结束毫秒时间戳
  public var endAt: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_MessageSyncV2Response {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 请求信息
  public var request: Api_Core_MessageSyncV2Request {
    get {return _request ?? Api_Core_MessageSyncV2Request()}
    set {_request = newValue}
  }
  /// Returns true if `request` has been explicitly set.
  public var hasRequest: Bool {return self._request != nil}
  /// Clears the value of `request`. Subsequent reads from it will return its default value.
  public mutating func clearRequest() {self._request = nil}

  /// 历史消息
  public var list: [CommonMessage] = []

  /// 已过滤最早id, 分页时传递给下一页
  public var lastMsgID: Int64 = 0

  public var nick: String = String()

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _request: Api_Core_MessageSyncV2Request? = nil
}

public struct Api_Core_MessageSearchRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 搜索关键词
  public var content: String = String()

  /// 会话id 可省略
  public var chatID: Int64 = 0

  /// 最早消息id, 用户分页加载更多数据
  public var msgID: Int64 = 0

  /// 开始时间
  public var start: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _start ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_start = newValue}
  }
  /// Returns true if `start` has been explicitly set.
  public var hasStart: Bool {return self._start != nil}
  /// Clears the value of `start`. Subsequent reads from it will return its default value.
  public mutating func clearStart() {self._start = nil}

  /// 结束时间
  public var end: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _end ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_end = newValue}
  }
  /// Returns true if `end` has been explicitly set.
  public var hasEnd: Bool {return self._end != nil}
  /// Clears the value of `end`. Subsequent reads from it will return its default value.
  public mutating func clearEnd() {self._end = nil}

  /// 加载多少条消息
  public var count: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _start: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _end: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

public struct Api_Core_MessageSearchResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 请求信息
  public var request: Api_Core_MessageSearchRequest {
    get {return _request ?? Api_Core_MessageSearchRequest()}
    set {_request = newValue}
  }
  /// Returns true if `request` has been explicitly set.
  public var hasRequest: Bool {return self._request != nil}
  /// Clears the value of `request`. Subsequent reads from it will return its default value.
  public mutating func clearRequest() {self._request = nil}

  /// 历史消息
  public var list: [CommonMessage] = []

  /// 已过滤最早id, 分页时传递给下一页
  public var lastMsgID: Int64 = 0

  /// TODO: 临时字段: 前端没有维护 会话信息, 需要先给会话关联的头像和姓名
  public var detail: Dictionary<Int64,CommonChatDetail> = [:]

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _request: Api_Core_MessageSearchRequest? = nil
}

public struct Api_Core_QuerySpecMsgRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 = 0

  public var msgID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_QuerySpecMsgResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var msg: CommonMessage {
    get {return _msg ?? CommonMessage()}
    set {_msg = newValue}
  }
  /// Returns true if `msg` has been explicitly set.
  public var hasMsg: Bool {return self._msg != nil}
  /// Clears the value of `msg`. Subsequent reads from it will return its default value.
  public mutating func clearMsg() {self._msg = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _msg: CommonMessage? = nil
}

public struct Api_Core_QuerySyncRequest {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 会话id 可省略
  public var chatID: Int64 = 0

  /// 最早消息id, 用户分页加载更多数据
  public var msgID: Int64 = 0

  /// 开始时间
  public var start: Int64 = 0

  /// 结束时间
  public var end: Int64 = 0

  /// 加载多少条消息
  public var count: Int32 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}
}

public struct Api_Core_QuerySyncResponse {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  /// 请求信息
  public var request: Api_Core_QuerySyncRequest {
    get {return _request ?? Api_Core_QuerySyncRequest()}
    set {_request = newValue}
  }
  /// Returns true if `request` has been explicitly set.
  public var hasRequest: Bool {return self._request != nil}
  /// Clears the value of `request`. Subsequent reads from it will return its default value.
  public mutating func clearRequest() {self._request = nil}

  /// 历史消息
  public var list: [CommonMessage] = []

  /// 已过滤最早id, 分页时传递给下一页
  public var lastMsgID: Int64 = 0

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _request: Api_Core_QuerySyncRequest? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension Api_Core_MessageSyncRequest: @unchecked Sendable {}
extension Api_Core_MessageSyncResponse: @unchecked Sendable {}
extension Api_Core_MessageSyncV2Request: @unchecked Sendable {}
extension Api_Core_MessageSyncV2Response: @unchecked Sendable {}
extension Api_Core_MessageSearchRequest: @unchecked Sendable {}
extension Api_Core_MessageSearchResponse: @unchecked Sendable {}
extension Api_Core_QuerySpecMsgRequest: @unchecked Sendable {}
extension Api_Core_QuerySpecMsgResponse: @unchecked Sendable {}
extension Api_Core_QuerySyncRequest: @unchecked Sendable {}
extension Api_Core_QuerySyncResponse: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "api.core"

extension Api_Core_MessageSyncRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSyncRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "msg_id"),
    3: .same(proto: "count"),
    4: .standard(proto: "with_last_one"),
    5: .standard(proto: "worker_id"),
    6: .standard(proto: "consult_id"),
    7: .standard(proto: "user_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.msgID) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.count) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.withLastOne) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      case 6: try { try decoder.decodeSingularUInt32Field(value: &self.consultID) }()
      case 7: try { try decoder.decodeSingularInt32Field(value: &self.userID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.msgID != 0 {
      try visitor.visitSingularInt64Field(value: self.msgID, fieldNumber: 2)
    }
    if self.count != 0 {
      try visitor.visitSingularInt32Field(value: self.count, fieldNumber: 3)
    }
    if self.withLastOne != false {
      try visitor.visitSingularBoolField(value: self.withLastOne, fieldNumber: 4)
    }
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 5)
    }
    if self.consultID != 0 {
      try visitor.visitSingularUInt32Field(value: self.consultID, fieldNumber: 6)
    }
    if self.userID != 0 {
      try visitor.visitSingularInt32Field(value: self.userID, fieldNumber: 7)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSyncRequest, rhs: Api_Core_MessageSyncRequest) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.msgID != rhs.msgID {return false}
    if lhs.count != rhs.count {return false}
    if lhs.withLastOne != rhs.withLastOne {return false}
    if lhs.workerID != rhs.workerID {return false}
    if lhs.consultID != rhs.consultID {return false}
    if lhs.userID != rhs.userID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MessageSyncResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSyncResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "request"),
    2: .same(proto: "list"),
    3: .standard(proto: "last_msg_id"),
    4: .same(proto: "nick"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._request) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.list) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.lastMsgID) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.nick) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._request {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.list.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.list, fieldNumber: 2)
    }
    if self.lastMsgID != 0 {
      try visitor.visitSingularInt64Field(value: self.lastMsgID, fieldNumber: 3)
    }
    if !self.nick.isEmpty {
      try visitor.visitSingularStringField(value: self.nick, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSyncResponse, rhs: Api_Core_MessageSyncResponse) -> Bool {
    if lhs._request != rhs._request {return false}
    if lhs.list != rhs.list {return false}
    if lhs.lastMsgID != rhs.lastMsgID {return false}
    if lhs.nick != rhs.nick {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MessageSyncV2Request: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSyncV2Request"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "msg_id"),
    3: .same(proto: "count"),
    4: .standard(proto: "with_last_one"),
    5: .standard(proto: "worker_id"),
    6: .standard(proto: "consult_id"),
    7: .standard(proto: "user_id"),
    8: .standard(proto: "start_at"),
    9: .standard(proto: "end_at"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.msgID) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.count) }()
      case 4: try { try decoder.decodeSingularBoolField(value: &self.withLastOne) }()
      case 5: try { try decoder.decodeSingularInt32Field(value: &self.workerID) }()
      case 6: try { try decoder.decodeSingularUInt32Field(value: &self.consultID) }()
      case 7: try { try decoder.decodeSingularInt32Field(value: &self.userID) }()
      case 8: try { try decoder.decodeSingularInt64Field(value: &self.startAt) }()
      case 9: try { try decoder.decodeSingularInt64Field(value: &self.endAt) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.msgID != 0 {
      try visitor.visitSingularInt64Field(value: self.msgID, fieldNumber: 2)
    }
    if self.count != 0 {
      try visitor.visitSingularInt32Field(value: self.count, fieldNumber: 3)
    }
    if self.withLastOne != false {
      try visitor.visitSingularBoolField(value: self.withLastOne, fieldNumber: 4)
    }
    if self.workerID != 0 {
      try visitor.visitSingularInt32Field(value: self.workerID, fieldNumber: 5)
    }
    if self.consultID != 0 {
      try visitor.visitSingularUInt32Field(value: self.consultID, fieldNumber: 6)
    }
    if self.userID != 0 {
      try visitor.visitSingularInt32Field(value: self.userID, fieldNumber: 7)
    }
    if self.startAt != 0 {
      try visitor.visitSingularInt64Field(value: self.startAt, fieldNumber: 8)
    }
    if self.endAt != 0 {
      try visitor.visitSingularInt64Field(value: self.endAt, fieldNumber: 9)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSyncV2Request, rhs: Api_Core_MessageSyncV2Request) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.msgID != rhs.msgID {return false}
    if lhs.count != rhs.count {return false}
    if lhs.withLastOne != rhs.withLastOne {return false}
    if lhs.workerID != rhs.workerID {return false}
    if lhs.consultID != rhs.consultID {return false}
    if lhs.userID != rhs.userID {return false}
    if lhs.startAt != rhs.startAt {return false}
    if lhs.endAt != rhs.endAt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MessageSyncV2Response: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSyncV2Response"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "request"),
    2: .same(proto: "list"),
    3: .standard(proto: "last_msg_id"),
    4: .same(proto: "nick"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._request) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.list) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.lastMsgID) }()
      case 4: try { try decoder.decodeSingularStringField(value: &self.nick) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._request {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.list.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.list, fieldNumber: 2)
    }
    if self.lastMsgID != 0 {
      try visitor.visitSingularInt64Field(value: self.lastMsgID, fieldNumber: 3)
    }
    if !self.nick.isEmpty {
      try visitor.visitSingularStringField(value: self.nick, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSyncV2Response, rhs: Api_Core_MessageSyncV2Response) -> Bool {
    if lhs._request != rhs._request {return false}
    if lhs.list != rhs.list {return false}
    if lhs.lastMsgID != rhs.lastMsgID {return false}
    if lhs.nick != rhs.nick {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MessageSearchRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSearchRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "content"),
    2: .standard(proto: "chat_id"),
    3: .standard(proto: "msg_id"),
    4: .same(proto: "start"),
    5: .same(proto: "end"),
    6: .same(proto: "count"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularStringField(value: &self.content) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.msgID) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._start) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._end) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self.count) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if !self.content.isEmpty {
      try visitor.visitSingularStringField(value: self.content, fieldNumber: 1)
    }
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 2)
    }
    if self.msgID != 0 {
      try visitor.visitSingularInt64Field(value: self.msgID, fieldNumber: 3)
    }
    try { if let v = self._start {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._end {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    if self.count != 0 {
      try visitor.visitSingularInt32Field(value: self.count, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSearchRequest, rhs: Api_Core_MessageSearchRequest) -> Bool {
    if lhs.content != rhs.content {return false}
    if lhs.chatID != rhs.chatID {return false}
    if lhs.msgID != rhs.msgID {return false}
    if lhs._start != rhs._start {return false}
    if lhs._end != rhs._end {return false}
    if lhs.count != rhs.count {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_MessageSearchResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".MessageSearchResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "request"),
    2: .same(proto: "list"),
    3: .standard(proto: "last_msg_id"),
    4: .same(proto: "detail"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._request) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.list) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.lastMsgID) }()
      case 4: try { try decoder.decodeMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufInt64,CommonChatDetail>.self, value: &self.detail) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._request {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.list.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.list, fieldNumber: 2)
    }
    if self.lastMsgID != 0 {
      try visitor.visitSingularInt64Field(value: self.lastMsgID, fieldNumber: 3)
    }
    if !self.detail.isEmpty {
      try visitor.visitMapField(fieldType: SwiftProtobuf._ProtobufMessageMap<SwiftProtobuf.ProtobufInt64,CommonChatDetail>.self, value: self.detail, fieldNumber: 4)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_MessageSearchResponse, rhs: Api_Core_MessageSearchResponse) -> Bool {
    if lhs._request != rhs._request {return false}
    if lhs.list != rhs.list {return false}
    if lhs.lastMsgID != rhs.lastMsgID {return false}
    if lhs.detail != rhs.detail {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_QuerySpecMsgRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".QuerySpecMsgRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "msg_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.msgID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.msgID != 0 {
      try visitor.visitSingularInt64Field(value: self.msgID, fieldNumber: 2)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_QuerySpecMsgRequest, rhs: Api_Core_QuerySpecMsgRequest) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.msgID != rhs.msgID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_QuerySpecMsgResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".QuerySpecMsgResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "msg"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._msg) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._msg {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_QuerySpecMsgResponse, rhs: Api_Core_QuerySpecMsgResponse) -> Bool {
    if lhs._msg != rhs._msg {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_QuerySyncRequest: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".QuerySyncRequest"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    2: .standard(proto: "chat_id"),
    3: .standard(proto: "msg_id"),
    4: .same(proto: "start"),
    5: .same(proto: "end"),
    6: .same(proto: "count"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 2: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.msgID) }()
      case 4: try { try decoder.decodeSingularInt64Field(value: &self.start) }()
      case 5: try { try decoder.decodeSingularInt64Field(value: &self.end) }()
      case 6: try { try decoder.decodeSingularInt32Field(value: &self.count) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 2)
    }
    if self.msgID != 0 {
      try visitor.visitSingularInt64Field(value: self.msgID, fieldNumber: 3)
    }
    if self.start != 0 {
      try visitor.visitSingularInt64Field(value: self.start, fieldNumber: 4)
    }
    if self.end != 0 {
      try visitor.visitSingularInt64Field(value: self.end, fieldNumber: 5)
    }
    if self.count != 0 {
      try visitor.visitSingularInt32Field(value: self.count, fieldNumber: 6)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_QuerySyncRequest, rhs: Api_Core_QuerySyncRequest) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.msgID != rhs.msgID {return false}
    if lhs.start != rhs.start {return false}
    if lhs.end != rhs.end {return false}
    if lhs.count != rhs.count {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension Api_Core_QuerySyncResponse: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".QuerySyncResponse"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "request"),
    2: .same(proto: "list"),
    3: .standard(proto: "last_msg_id"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularMessageField(value: &self._request) }()
      case 2: try { try decoder.decodeRepeatedMessageField(value: &self.list) }()
      case 3: try { try decoder.decodeSingularInt64Field(value: &self.lastMsgID) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    try { if let v = self._request {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
    } }()
    if !self.list.isEmpty {
      try visitor.visitRepeatedMessageField(value: self.list, fieldNumber: 2)
    }
    if self.lastMsgID != 0 {
      try visitor.visitSingularInt64Field(value: self.lastMsgID, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: Api_Core_QuerySyncResponse, rhs: Api_Core_QuerySyncResponse) -> Bool {
    if lhs._request != rhs._request {return false}
    if lhs.list != rhs.list {return false}
    if lhs.lastMsgID != rhs.lastMsgID {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
