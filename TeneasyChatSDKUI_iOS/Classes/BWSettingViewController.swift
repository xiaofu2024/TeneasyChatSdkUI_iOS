//
//  BWSettingViewController.swift
//  Alamofire
//
//  Created by Xiao Fu on 2024/5/17.
//
import UIKit
import SnapKit

class BWSettingViewController: UIViewController {
    
    private let linesTextField = UITextField()
    private let certTextField = UITextField()
    private let merchantIdTextField = UITextField()
    private let userIdTextField = UITextField()
    private let submitButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        let labels = ["lines", "cert", "merchantId", "userId"]
        let textFields = [linesTextField, certTextField, merchantIdTextField, userIdTextField]
        
        for (index, labelName) in labels.enumerated() {
            let label = UILabel()
            label.text = labelName
            view.addSubview(label)
            
            let textField = textFields[index]
            textField.borderStyle = .roundedRect
            view.addSubview(textField)
            
            label.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(100 + index * 60)
                make.left.equalToSuperview().offset(20)
                make.width.equalTo(100)
            }
            
            textField.snp.makeConstraints { make in
                make.centerY.equalTo(label)
                make.left.equalTo(label.snp.right).offset(10)
                make.right.equalToSuperview().offset(-20)
                make.height.equalTo(40)
            }
        }
        
        submitButton.setTitle("确定", for: .normal)
        submitButton.addTarget(self, action: #selector(submitButtonTapped), for: .touchUpInside)
        view.addSubview(submitButton)
        
        submitButton.snp.makeConstraints { make in
            make.top.equalTo(userIdTextField.snp.bottom).offset(40)
            make.centerX.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(50)
        }
    }
    
    @objc private func submitButtonTapped() {
        let lines = linesTextField.text ?? ""
        let cert = certTextField.text ?? ""
        let merchantId = merchantIdTextField.text ?? ""
        let userId = userIdTextField.text ?? ""
        
        UserDefaults.standard.set(lines, forKey: PARAM_LINES)
        UserDefaults.standard.set(cert, forKey: PARAM_CERT)
        UserDefaults.standard.set(merchantId, forKey: PARAM_MERCHANT_ID)
        UserDefaults.standard.set(userId, forKey: PARAM_USER_ID)
        
        self.dismiss(animated: true)
//        let alert = UIAlertController(title: "保存成功", message: "您的信息已保存。", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "确定", style: .default, handler: nil))
//        present(alert, animated: true, completion: nil)
    }
}

