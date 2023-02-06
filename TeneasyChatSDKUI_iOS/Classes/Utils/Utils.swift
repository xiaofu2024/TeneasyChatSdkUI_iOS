//
//  Utils.swift
//  TeneasyChatSDK_iOS_Example
//
//  Created by XiaoFu on 30/1/23.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Foundation
import SVGKit

extension Date {
   func getFormattedDate(format: String) -> String {
        let dateformat = DateFormatter()
        dateformat.dateFormat = format
        return dateformat.string(from: self)
    }
    
    /// 时间戳转成字符串
    func timeIntervalChangeToTimeStr(dateFormat:String?) -> String {
        let formatter = DateFormatter.init()
        if dateFormat == nil {
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        }else{
            formatter.dateFormat = dateFormat
        }
        return formatter.string(from: self)
    }
    

        func currentTimeMillis() -> Int64 {
            return Int64(self.timeIntervalSince1970 * 1000)
        }
    
}


extension UIImage{
    ///svg初始化
    static func svgInit(_ name:String) -> UIImage?{
        let svg = SVGKImage.init(named: name, in: BundleUtil.getCurrentBundle())
        return svg?.uiImage
    }
    
    static func svgInit(_ name:String,size:CGSize) -> UIImage?{
        let svg = SVGKImage.init(named: name, in: BundleUtil.getCurrentBundle())
        if size != .zero{
            svg?.size = size
        }
        return svg?.uiImage
    }
    
    static func svgView(_ name:String)->SVGKLayeredImageView?{
        let svg:SVGKImage=SVGKImage(named: "lt_zuixinweizhi", in: BundleUtil.getCurrentBundle())
        let svgView = SVGKLayeredImageView(svgkImage: svg)
        return svgView
    }
}
