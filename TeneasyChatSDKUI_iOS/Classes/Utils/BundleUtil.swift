//
//  BundleUtil.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by darren chen on 2023/2/1.
//

import UIKit
import Foundation

class BundleUtil {
    
    static func getCurrentBundle() -> Bundle{
        
        let podBundle = Bundle(for: ChatViewController.self)
        
        let bundleURL = podBundle.url(forResource: "TeneasyChatSdkUI_iOS", withExtension: "bundle")
        
        if bundleURL == nil {
            if podBundle.bundlePath.contains("TeneasyChatSdkUI_iOS.framework") {   // carthage
                return podBundle
            }
        }
        
        if bundleURL != nil {
            let bundle = Bundle(url: bundleURL!)!
            return bundle
        } else{
            return Bundle.main
        }
    }
}
