//
//  Utils.swift
//  TeneasyChatSDK_iOS_Example
//
//  Created by XiaoFu on 30/1/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
}
