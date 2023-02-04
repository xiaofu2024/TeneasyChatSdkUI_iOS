//
//  ChatModel.swift
//  TeneasyChatSDKUI_iOS_Example
//
//  Created by XiaoFu on 2023/2/1.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import TeneasyChatSDK_iOS

enum MessageSendState:String { case 发送中="0", 发送成功="1", 发送失败="2", 未知="-1" }
    class ChatModel {
    var message: CommonMessage!
    var isLeft: Bool = false
        var payLoadId: UInt64 = 0
}
