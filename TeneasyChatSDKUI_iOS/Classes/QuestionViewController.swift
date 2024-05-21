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
    
    lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("setting", for: UIControl.State.normal)
        btn.setTitleColor(.blue, for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(settingClick), for: UIControl.Event.touchUpInside)
        return btn
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .groupTableViewBackground
        self.view.addSubview(entranceView)
        entranceView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12 + kDeviceTop)
            make.bottom.equalToSuperview().offset(-52 - kDeviceBottom)
        }
        entranceView.callBack = {[weak self] (dataCount: Int) in
        }
        entranceView.cellClick = {[weak self] (consultID: Int32) in
            let vc = KeFuViewController()
            vc.consultId = Int64(consultID)
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        view.addSubview(self.settingBtn)
        self.settingBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-40)
            make.right.equalToSuperview().offset(-20)
        }
    }
    @objc func settingClick() {
        let vc = BWSettingViewController()
        self.present(vc, animated: true)
    }
    
    open override func viewWillDisappear(_ animated: Bool) {

    }
}
