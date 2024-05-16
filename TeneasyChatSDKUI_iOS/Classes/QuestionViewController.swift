//
//  QuestionViewController.swift
//  TeneasyChatSDKUI_iOS-TeneasyChatSDKUI_iOS
//
//  Created by Xiao Fu on 2024/5/10.
//

import Foundation
import UIKit
import TeneasyChatSDK_iOS

open class QuestionViewController: UIViewController {
    
    lazy var entranceView: BWEntranceView = {
        let view = BWEntranceView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .groupTableViewBackground
        self.view.addSubview(entranceView)
        entranceView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12 + kDeviceTop)
            make.bottom.equalToSuperview().offset(-12 - kDeviceBottom)
        }
        entranceView.callBack = {[weak self] (dataCount: Int) in
        }
        entranceView.cellClick = {[weak self] (consultID: Int32) in
            let vc = KeFuViewController()
            vc.consultId = Int64(consultID)
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
    }
    
    open override func viewWillDisappear(_ animated: Bool) {

    }
}
