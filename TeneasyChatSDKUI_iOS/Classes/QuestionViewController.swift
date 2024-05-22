//
//  QuestionViewController.swift
//  TeneasyChatSDKUI_iOS-TeneasyChatSDKUI_iOS
//
//  Created by Xiao Fu on 2024/5/10.
//

import Foundation
import UIKit
import TeneasyChatSDK_iOS

open class QuestionViewController: UIViewController, LineDetectDelegate {
    public func useTheLine(line: String) {
        curLineLB.text = "当前线路：\(line)"
    }
    
    public func lineError(error: TeneasyChatSDK_iOS.Result) {
        if error.Code == 1008{
            curLineLB.text = error.Message
        }
        debugPrint(error.Message)
    }
    
    
    lazy var entranceView: BWEntranceView = {
        let view = BWEntranceView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var curLineLB: UILabel = {
        let lineLB = UILabel()
        lineLB.text = "正在检测线路。。。。"
        lineLB.textColor = UIColor.white
        lineLB.font = UIFont.systemFont(ofSize: 15)
        return lineLB
    }()
    
    lazy var settingBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("Settings", for: UIControl.State.normal)
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
            make.bottom.equalToSuperview().offset(-82 - kDeviceBottom)
        }
        
        self.view.addSubview(curLineLB)
        curLineLB.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)

            make.top.equalTo(entranceView.snp.bottom).offset(10)
        }
        
        entranceView.callBack = { (dataCount: Int) in
        }
        entranceView.cellClick = {[weak self] (consultID: Int32) in
            let vc = KeFuViewController()
            vc.consultId = Int64(consultID)
            vc.modalPresentationStyle = .fullScreen
            self?.present(vc, animated: true)
        }
        
        view.addSubview(self.settingBtn)
        self.settingBtn.snp.makeConstraints { make in
            make.top.equalTo(curLineLB.snp.bottom).offset(10)
            make.right.equalToSuperview().offset(-20)
        }
        
        let lineLB = LineDetectLib(lines, delegate: self, tenantId: merchantId)
        lineLB.getLine()
    }
    @objc func settingClick() {
        let vc = BWSettingViewController()
        self.present(vc, animated: true)
    }
    
    
    open override func viewWillDisappear(_ animated: Bool) {

    }
}
