//
//  BWChatCell.swift
//  TeneasyChatSDKUI_iOS_Example
//
//  Created by XiaoFu on 2023/2/1.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import Kingfisher
import UIKit

class BWChatCell: UITableViewCell {
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .black
        lab.lineBreakMode = .byTruncatingTail
        return lab
    }()
    
    lazy var imgView: UIImageView = {
        let v = UIImageView()
        return v
    }()

    lazy var titleLab: BWLabel = {
        let lab = BWLabel()
        lab.font = UIFont.systemFont(ofSize: 15)
        lab.textColor = .black
        lab.numberOfLines = 1000
        lab.textInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        lab.preferredMaxLayoutWidth = kScreenWidth - 100
        return lab
    }()
    
    lazy var failedDotView: UIImageView = {
        let v = UIImageView()
        return v
    }()
    
    static func cell(tableView: UITableView) -> Self {
        let cellId = "\(Self.self)"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = Self(style: .default, reuseIdentifier: cellId)
        }
        
        return cell as! Self
    }
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        
        self.addSubview(self.timeLab)
        self.addSubview(self.titleLab)
        self.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-100)
            make.top.equalTo(self.timeLab.snp.bottom)
            make.height.equalTo(160)
        }
    }
    
    var model: ChatModel? {
        didSet {
            // 现在SDK并没有把时间传回来，所以暂时不用这样转换
            if let mTime = model?.message.msgTime {
                self.timeLab.text = WTimeConvertUtil.displayLocalTime(from: mTime.date)
            }
            if self.model?.message.content.data.contains("[emoticon_") == true {
                let atttext = BEmotionHelper.shared.attributedStringByText(text: self.model?.message.content.data ?? "", font: self.titleLab.font)
                self.titleLab.attributedText = atttext
            } else {
                self.titleLab.text = self.model?.message.content.data
            }
            if self.model?.message.image.uri.isEmpty == false {
                let imgUrl = URL(string: model?.message.image.uri ?? "")
                print(imgUrl?.absoluteURL)
                if imgUrl != nil {
                    self.initImg(imgUrl: imgUrl!)
                } else {
                    self.initTitle()
                }
            } else {
                self.initTitle()
            }
        }
    }
    
    func initImg(imgUrl: URL) {
        self.imgView.kf.setImage(with: imgUrl)
        self.imgView.snp.updateConstraints { make in
            make.height.equalTo(160)
        }
        self.titleLab.isHidden = true
        
    }

    func initTitle() {
        self.imgView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        self.titleLab.isHidden = false
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BWChatLeftCell: BWChatCell {
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.titleLab.backgroundColor = .white

        self.timeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        self.titleLab.snp.makeConstraints { make in
            make.top.equalTo(self.imgView.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
typealias  BWChatRightCellResendBlock = (String) -> ()

class BWChatRightCell: BWChatCell {
    var resendBlock: BWChatRightCellResendBlock?

    lazy var loadingView: UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        return img
    }()
    
    required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLab.backgroundColor = UIColor(red: 253/255, green: 230/255, blue: 89/255, alpha: 1)

        self.timeLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        self.titleLab.snp.makeConstraints { make in
            make.top.equalTo(self.imgView.snp.bottom)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }
        self.addSubview(self.loadingView)
        self.loadingView.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.right.equalTo(self.titleLab.snp.left).offset(-10)
        }
        
        self.loadingView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(clickErrorIcon)))
    }
    
    @objc func clickErrorIcon() {
        self.resendBlock!(self.titleLab.text ?? "")
    }
    
    override func initTitle() {
        super.initTitle()
        self.initLoadingForTitel()
    }

    override func initImg(imgUrl: URL) {
        super.initImg(imgUrl: imgUrl)
        self.initLoadingForImage()
    }
    
    func initLoadingForTitel() {
        self.loadingView.snp.makeConstraints { make in
            make.centerY.equalTo(self.titleLab.snp.centerY)
            make.right.equalTo(self.titleLab.snp.left).offset(-10)
        }
        self.initLoadingicon()
    }

    func initLoadingForImage() {
        self.loadingView.snp.makeConstraints { make in
            make.centerY.equalTo(self.imgView.snp.centerY)
            make.right.equalTo(self.imgView.snp.left).offset(-10)
        }
        self.initLoadingicon()
    }
    
    func initLoadingicon() {
        let path = BundleUtil.getCurrentBundle().path(forResource:"clock", ofType:"gif")
        let url = URL(fileURLWithPath: path!)
        let provider = LocalFileImageDataProvider(fileURL: url)
        if model?.sendStatus == .发送中 {
            self.loadingView.kf.setImage(with: provider)
            self.loadingView.isHidden = false
        } else if model?.sendStatus == .发送成功 {
            self.loadingView.isHidden = true
        } else if model?.sendStatus == .发送失败 {
            self.loadingView.image = UIImage.svgInit("error")
            self.loadingView.isHidden = false
        } else {
            self.loadingView.kf.setImage(with: provider)
            self.loadingView.isHidden = false
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
