//
//  BWChatCell.swift
//  TeneasyChatSDKUI_iOS_Example
//
//  Created by XiaoFu on 2023/2/1.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit
import Kingfisher

class BWChatCell: UITableViewCell {
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .black
        lab.lineBreakMode = .byTruncatingTail
        return lab
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

    lazy var imgView: UIImageView = {
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
            self.titleLab.text = model?.message.content.data
            if model?.message.image.uri.isEmpty == false {
                let imgUrl = URL(string: model?.message.image.uri ?? "")
                if imgUrl != nil {
                    imgView.kf.setImage(with: imgUrl!)
                    self.imgView.snp.updateConstraints { make in
                        make.height.equalTo(160)
                    }
                } else {
                    self.imgView.snp.updateConstraints { make in
                        make.height.equalTo(0)
                    }
                }
                
            } else {
                self.imgView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
            }
        }
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

class BWChatRightCell: BWChatCell {
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
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
