// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: api/common/c_chat.proto
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

public struct CommonChatDetail {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 {
    get {return _storage._chatID}
    set {_uniqueStorage()._chatID = newValue}
  }

  /// 入口id
  public var entranceID: UInt32 {
    get {return _storage._entranceID}
    set {_uniqueStorage()._entranceID = newValue}
  }

  /// 入口名称
  public var entranceName: String {
    get {return _storage._entranceName}
    set {_uniqueStorage()._entranceName = newValue}
  }

  /// 用户来源
  public var platform: String {
    get {return _storage._platform}
    set {_uniqueStorage()._platform = newValue}
  }

  /// IP
  public var ip: String {
    get {return _storage._ip}
    set {_uniqueStorage()._ip = newValue}
  }

  /// 分配客服时间
  public var createAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._createAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._createAt = newValue}
  }
  /// Returns true if `createAt` has been explicitly set.
  public var hasCreateAt: Bool {return _storage._createAt != nil}
  /// Clears the value of `createAt`. Subsequent reads from it will return its default value.
  public mutating func clearCreateAt() {_uniqueStorage()._createAt = nil}

  /// 最后一次上线时间
  public var updateAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._updateAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._updateAt = newValue}
  }
  /// Returns true if `updateAt` has been explicitly set.
  public var hasUpdateAt: Bool {return _storage._updateAt != nil}
  /// Clears the value of `updateAt`. Subsequent reads from it will return its default value.
  public mutating func clearUpdateAt() {_uniqueStorage()._updateAt = nil}

  /// 用户名
  public var name: String {
    get {return _storage._name}
    set {_uniqueStorage()._name = newValue}
  }

  /// 用户头像
  public var avatar: String {
    get {return _storage._avatar}
    set {_uniqueStorage()._avatar = newValue}
  }

  /// 用户称呼(备注)
  public var nick: String {
    get {return _storage._nick}
    set {_uniqueStorage()._nick = newValue}
  }

  /// 用户诉求
  public var appeal: String {
    get {return _storage._appeal}
    set {_uniqueStorage()._appeal = newValue}
  }

  /// 重新打开会话时间
  public var resetAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _storage._resetAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_uniqueStorage()._resetAt = newValue}
  }
  /// Returns true if `resetAt` has been explicitly set.
  public var hasResetAt: Bool {return _storage._resetAt != nil}
  /// Clears the value of `resetAt`. Subsequent reads from it will return its default value.
  public mutating func clearResetAt() {_uniqueStorage()._resetAt = nil}

  /// 用户类型，匿名，注册
  /// 授权角色
  public var ownerRole: CommonMessageRole {
    get {return _storage._ownerRole}
    set {_uniqueStorage()._ownerRole = newValue}
  }

  /// 云信账号，针对注册用户
  public var nimName: String {
    get {return _storage._nimName ?? String()}
    set {_uniqueStorage()._nimName = newValue}
  }
  /// Returns true if `nimName` has been explicitly set.
  public var hasNimName: Bool {return _storage._nimName != nil}
  /// Clears the value of `nimName`. Subsequent reads from it will return its default value.
  public mutating func clearNimName() {_uniqueStorage()._nimName = nil}

  /// 云信账号，针对注册用户
  public var userid: Int32 {
    get {return _storage._userid}
    set {_uniqueStorage()._userid = newValue}
  }

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

public struct CommonChatItem {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  public var chatID: Int64 = 0

  public var state: CommonChatState = .common

  public var unread: Int32 = 0

  public var latestMsg: CommonMessage {
    get {return _latestMsg ?? CommonMessage()}
    set {_latestMsg = newValue}
  }
  /// Returns true if `latestMsg` has been explicitly set.
  public var hasLatestMsg: Bool {return self._latestMsg != nil}
  /// Clears the value of `latestMsg`. Subsequent reads from it will return its default value.
  public mutating func clearLatestMsg() {self._latestMsg = nil}

  /// 分配客服时间
  public var createAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _createAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_createAt = newValue}
  }
  /// Returns true if `createAt` has been explicitly set.
  public var hasCreateAt: Bool {return self._createAt != nil}
  /// Clears the value of `createAt`. Subsequent reads from it will return its default value.
  public mutating func clearCreateAt() {self._createAt = nil}

  /// 第一次服务时间
  public var serviceAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _serviceAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_serviceAt = newValue}
  }
  /// Returns true if `serviceAt` has been explicitly set.
  public var hasServiceAt: Bool {return self._serviceAt != nil}
  /// Clears the value of `serviceAt`. Subsequent reads from it will return its default value.
  public mutating func clearServiceAt() {self._serviceAt = nil}

  /// 会话详情
  public var detail: CommonChatDetail {
    get {return _detail ?? CommonChatDetail()}
    set {_detail = newValue}
  }
  /// Returns true if `detail` has been explicitly set.
  public var hasDetail: Bool {return self._detail != nil}
  /// Clears the value of `detail`. Subsequent reads from it will return its default value.
  public mutating func clearDetail() {self._detail = nil}

  /// 重新打开会话时间
  public var resetAt: SwiftProtobuf.Google_Protobuf_Timestamp {
    get {return _resetAt ?? SwiftProtobuf.Google_Protobuf_Timestamp()}
    set {_resetAt = newValue}
  }
  /// Returns true if `resetAt` has been explicitly set.
  public var hasResetAt: Bool {return self._resetAt != nil}
  /// Clears the value of `resetAt`. Subsequent reads from it will return its default value.
  public mutating func clearResetAt() {self._resetAt = nil}

  public var unknownFields = SwiftProtobuf.UnknownStorage()

  public init() {}

  fileprivate var _latestMsg: CommonMessage? = nil
  fileprivate var _createAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _serviceAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
  fileprivate var _detail: CommonChatDetail? = nil
  fileprivate var _resetAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
}

#if swift(>=5.5) && canImport(_Concurrency)
extension CommonChatDetail: @unchecked Sendable {}
extension CommonChatItem: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

fileprivate let _protobuf_package = "api.common"

extension CommonChatDetail: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatDetail"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .standard(proto: "entrance_id"),
    3: .standard(proto: "entrance_name"),
    4: .same(proto: "platform"),
    5: .same(proto: "ip"),
    6: .standard(proto: "create_at"),
    7: .standard(proto: "update_at"),
    8: .same(proto: "name"),
    9: .same(proto: "avatar"),
    10: .same(proto: "nick"),
    11: .same(proto: "appeal"),
    12: .standard(proto: "reset_at"),
    13: .standard(proto: "owner_role"),
    14: .same(proto: "nimName"),
    15: .same(proto: "userid"),
  ]

  fileprivate class _StorageClass {
    var _chatID: Int64 = 0
    var _entranceID: UInt32 = 0
    var _entranceName: String = String()
    var _platform: String = String()
    var _ip: String = String()
    var _createAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _updateAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _name: String = String()
    var _avatar: String = String()
    var _nick: String = String()
    var _appeal: String = String()
    var _resetAt: SwiftProtobuf.Google_Protobuf_Timestamp? = nil
    var _ownerRole: CommonMessageRole = .msgRoleSystem
    var _nimName: String? = nil
    var _userid: Int32 = 0

    #if swift(>=5.10)
      // This property is used as the initial default value for new instances of the type.
      // The type itself is protecting the reference to its storage via CoW semantics.
      // This will force a copy to be made of this reference when the first mutation occurs;
      // hence, it is safe to mark this as `nonisolated(unsafe)`.
      static nonisolated(unsafe) let defaultInstance = _StorageClass()
    #else
      static let defaultInstance = _StorageClass()
    #endif

    private init() {}

    init(copying source: _StorageClass) {
      _chatID = source._chatID
      _entranceID = source._entranceID
      _entranceName = source._entranceName
      _platform = source._platform
      _ip = source._ip
      _createAt = source._createAt
      _updateAt = source._updateAt
      _name = source._name
      _avatar = source._avatar
      _nick = source._nick
      _appeal = source._appeal
      _resetAt = source._resetAt
      _ownerRole = source._ownerRole
      _nimName = source._nimName
      _userid = source._userid
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularInt64Field(value: &_storage._chatID) }()
        case 2: try { try decoder.decodeSingularUInt32Field(value: &_storage._entranceID) }()
        case 3: try { try decoder.decodeSingularStringField(value: &_storage._entranceName) }()
        case 4: try { try decoder.decodeSingularStringField(value: &_storage._platform) }()
        case 5: try { try decoder.decodeSingularStringField(value: &_storage._ip) }()
        case 6: try { try decoder.decodeSingularMessageField(value: &_storage._createAt) }()
        case 7: try { try decoder.decodeSingularMessageField(value: &_storage._updateAt) }()
        case 8: try { try decoder.decodeSingularStringField(value: &_storage._name) }()
        case 9: try { try decoder.decodeSingularStringField(value: &_storage._avatar) }()
        case 10: try { try decoder.decodeSingularStringField(value: &_storage._nick) }()
        case 11: try { try decoder.decodeSingularStringField(value: &_storage._appeal) }()
        case 12: try { try decoder.decodeSingularMessageField(value: &_storage._resetAt) }()
        case 13: try { try decoder.decodeSingularEnumField(value: &_storage._ownerRole) }()
        case 14: try { try decoder.decodeSingularStringField(value: &_storage._nimName) }()
        case 15: try { try decoder.decodeSingularInt32Field(value: &_storage._userid) }()
        default: break
        }
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every if/case branch local when no optimizations
      // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
      // https://github.com/apple/swift-protobuf/issues/1182
      if _storage._chatID != 0 {
        try visitor.visitSingularInt64Field(value: _storage._chatID, fieldNumber: 1)
      }
      if _storage._entranceID != 0 {
        try visitor.visitSingularUInt32Field(value: _storage._entranceID, fieldNumber: 2)
      }
      if !_storage._entranceName.isEmpty {
        try visitor.visitSingularStringField(value: _storage._entranceName, fieldNumber: 3)
      }
      if !_storage._platform.isEmpty {
        try visitor.visitSingularStringField(value: _storage._platform, fieldNumber: 4)
      }
      if !_storage._ip.isEmpty {
        try visitor.visitSingularStringField(value: _storage._ip, fieldNumber: 5)
      }
      try { if let v = _storage._createAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
      } }()
      try { if let v = _storage._updateAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      } }()
      if !_storage._name.isEmpty {
        try visitor.visitSingularStringField(value: _storage._name, fieldNumber: 8)
      }
      if !_storage._avatar.isEmpty {
        try visitor.visitSingularStringField(value: _storage._avatar, fieldNumber: 9)
      }
      if !_storage._nick.isEmpty {
        try visitor.visitSingularStringField(value: _storage._nick, fieldNumber: 10)
      }
      if !_storage._appeal.isEmpty {
        try visitor.visitSingularStringField(value: _storage._appeal, fieldNumber: 11)
      }
      try { if let v = _storage._resetAt {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 12)
      } }()
      if _storage._ownerRole != .msgRoleSystem {
        try visitor.visitSingularEnumField(value: _storage._ownerRole, fieldNumber: 13)
      }
      try { if let v = _storage._nimName {
        try visitor.visitSingularStringField(value: v, fieldNumber: 14)
      } }()
      if _storage._userid != 0 {
        try visitor.visitSingularInt32Field(value: _storage._userid, fieldNumber: 15)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommonChatDetail, rhs: CommonChatDetail) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._chatID != rhs_storage._chatID {return false}
        if _storage._entranceID != rhs_storage._entranceID {return false}
        if _storage._entranceName != rhs_storage._entranceName {return false}
        if _storage._platform != rhs_storage._platform {return false}
        if _storage._ip != rhs_storage._ip {return false}
        if _storage._createAt != rhs_storage._createAt {return false}
        if _storage._updateAt != rhs_storage._updateAt {return false}
        if _storage._name != rhs_storage._name {return false}
        if _storage._avatar != rhs_storage._avatar {return false}
        if _storage._nick != rhs_storage._nick {return false}
        if _storage._appeal != rhs_storage._appeal {return false}
        if _storage._resetAt != rhs_storage._resetAt {return false}
        if _storage._ownerRole != rhs_storage._ownerRole {return false}
        if _storage._nimName != rhs_storage._nimName {return false}
        if _storage._userid != rhs_storage._userid {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension CommonChatItem: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  public static let protoMessageName: String = _protobuf_package + ".ChatItem"
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .standard(proto: "chat_id"),
    2: .same(proto: "state"),
    3: .same(proto: "unread"),
    4: .standard(proto: "latest_msg"),
    5: .standard(proto: "create_at"),
    6: .standard(proto: "service_at"),
    7: .same(proto: "detail"),
    8: .standard(proto: "reset_at"),
  ]

  public mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularInt64Field(value: &self.chatID) }()
      case 2: try { try decoder.decodeSingularEnumField(value: &self.state) }()
      case 3: try { try decoder.decodeSingularInt32Field(value: &self.unread) }()
      case 4: try { try decoder.decodeSingularMessageField(value: &self._latestMsg) }()
      case 5: try { try decoder.decodeSingularMessageField(value: &self._createAt) }()
      case 6: try { try decoder.decodeSingularMessageField(value: &self._serviceAt) }()
      case 7: try { try decoder.decodeSingularMessageField(value: &self._detail) }()
      case 8: try { try decoder.decodeSingularMessageField(value: &self._resetAt) }()
      default: break
      }
    }
  }

  public func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    // The use of inline closures is to circumvent an issue where the compiler
    // allocates stack space for every if/case branch local when no optimizations
    // are enabled. https://github.com/apple/swift-protobuf/issues/1034 and
    // https://github.com/apple/swift-protobuf/issues/1182
    if self.chatID != 0 {
      try visitor.visitSingularInt64Field(value: self.chatID, fieldNumber: 1)
    }
    if self.state != .common {
      try visitor.visitSingularEnumField(value: self.state, fieldNumber: 2)
    }
    if self.unread != 0 {
      try visitor.visitSingularInt32Field(value: self.unread, fieldNumber: 3)
    }
    try { if let v = self._latestMsg {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 4)
    } }()
    try { if let v = self._createAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 5)
    } }()
    try { if let v = self._serviceAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 6)
    } }()
    try { if let v = self._detail {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
    } }()
    try { if let v = self._resetAt {
      try visitor.visitSingularMessageField(value: v, fieldNumber: 8)
    } }()
    try unknownFields.traverse(visitor: &visitor)
  }

  public static func ==(lhs: CommonChatItem, rhs: CommonChatItem) -> Bool {
    if lhs.chatID != rhs.chatID {return false}
    if lhs.state != rhs.state {return false}
    if lhs.unread != rhs.unread {return false}
    if lhs._latestMsg != rhs._latestMsg {return false}
    if lhs._createAt != rhs._createAt {return false}
    if lhs._serviceAt != rhs._serviceAt {return false}
    if lhs._detail != rhs._detail {return false}
    if lhs._resetAt != rhs._resetAt {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
