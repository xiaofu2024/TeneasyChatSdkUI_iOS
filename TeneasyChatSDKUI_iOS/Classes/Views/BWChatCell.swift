//
//  BWChatCell.swift
//  TeneasyChatSDKUI_iOS_Example
//
//  Created by XiaoFu on 2023/2/1.
//  Copyright © 2023 CocoaPods. All rights reserved.
//

import UIKit

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
        lab.textInsets = UIEdgeInsets.init(top: 5, left: 5, bottom: 5, right: 5)
        lab.preferredMaxLayoutWidth = kScreenWidth - 100
        return lab
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
        
    }
    
    var model: ChatModel? {
        didSet {
            self.timeLab.text =  self.timeIntervalChangeToTimeStr(timeInterval: Double(model?.message.msgTime.seconds ?? 0))
            self.titleLab.text = model?.message.content.data
        }
    }
    func timeIntervalChangeToTimeStr(timeInterval:Double, _ dateFormat:String? = "yyyy-MM-dd HH:mm:ss") -> String {
            let date:Date = Date.init(timeIntervalSince1970: timeInterval)
            let formatter = DateFormatter.init()
            if dateFormat == nil {
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            }else{
                formatter.dateFormat = dateFormat
            }
            return formatter.string(from: date as Date)
        }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BWChatLeftCell: BWChatCell {
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.titleLab.backgroundColor = .white

        self.timeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        self.titleLab.snp.makeConstraints { make in
            make.top.equalTo(self.timeLab.snp.bottom)
            make.left.equalToSuperview().offset(12)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class BWChatRightCell: BWChatCell {
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.titleLab.backgroundColor = UIColor(red: 253/255, green: 230/255, blue: 89/255, alpha: 1)

        self.timeLab.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(12)
            make.height.equalTo(20)
        }
        self.titleLab.snp.makeConstraints { make in
            make.top.equalTo(self.timeLab.snp.bottom)
            make.right.equalToSuperview().offset(-12)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
