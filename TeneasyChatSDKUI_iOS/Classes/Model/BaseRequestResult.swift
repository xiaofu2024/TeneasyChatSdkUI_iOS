//
//  BaseRequestResult.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by darren chen on 2023/2/8.
//

import Foundation
import HandyJSON

class BaseRequestResult: HandyJSON {
    var code: Int?
    var success: Bool?
    required init() {}
}

class WorkerModel: HandyJSON {
//    var code: Int?
//    var success: Bool?
    required init() {}
}
