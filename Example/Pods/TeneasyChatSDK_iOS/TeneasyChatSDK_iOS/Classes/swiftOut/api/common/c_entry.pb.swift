// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: api/common/c_entry.proto
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

public enum Api_Common_TransportType: SwiftProtobuf.Enum {
  public typealias RawValue = Int
  case transportHTTP // = 0
  case transportHTTPS // = 3
  case transportH2C // = 5
  case transportHTTP3 // = 30
  case UNRECOGNIZED(Int)

  public init() {
    self = .transportHTTP
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .transportHTTP
    case 3: self = .transportHTTPS
    case 5: self = .transportH2C
    case 30: self = .transportHTTP3
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .transportHTTP: return 0
    case .transportHTTPS: return 3
    case .transportH2C: return 5
    case .transportHTTP3: return 30
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Api_Common_TransportType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Api_Common_TransportType] = [
    .transportHTTP,
    .transportHTTPS,
    .transportH2C,
    .transportHTTP3,
  ]
}

#endif  // swift(>=4.2)

public enum Api_Common_AddressType: SwiftProtobuf.Enum {
  public typealias RawValue = Int

  /// 域名
  case addresDomain // = 0

  /// ip4
  case addresIpv4 // = 1

  /// ip6
  case addresIpv6 // = 2
  case UNRECOGNIZED(Int)

  public init() {
    self = .addresDomain
  }

  public init?(rawValue: Int) {
    switch rawValue {
    case 0: self = .addresDomain
    case 1: self = .addresIpv4
    case 2: self = .addresIpv6
    default: self = .UNRECOGNIZED(rawValue)
    }
  }

  public var rawValue: Int {
    switch self {
    case .addresDomain: return 0
    case .addresIpv4: return 1
    case .addresIpv6: return 2
    case .UNRECOGNIZED(let i): return i
    }
  }

}

#if swift(>=4.2)

extension Api_Common_AddressType: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  public static var allCases: [Api_Common_AddressType] = [
    .addresDomain,
    .addresIpv4,
    .addresIpv6,
  ]
}

#endif  // swift(>=4.2)

#if swift(>=5.5) && canImport(_Concurrency)
extension Api_Common_TransportType: @unchecked Sendable {}
extension Api_Common_AddressType: @unchecked Sendable {}
#endif  // swift(>=5.5) && canImport(_Concurrency)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension Api_Common_TransportType: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "TRANSPORT_HTTP"),
    3: .same(proto: "TRANSPORT_HTTPS"),
    5: .same(proto: "TRANSPORT_H2C"),
    30: .same(proto: "TRANSPORT_HTTP3"),
  ]
}

extension Api_Common_AddressType: SwiftProtobuf._ProtoNameProviding {
  public static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "ADDRES_DOMAIN"),
    1: .same(proto: "ADDRES_IPV4"),
    2: .same(proto: "addres_ipv6"),
  ]
}
