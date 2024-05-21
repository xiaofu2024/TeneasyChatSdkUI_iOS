//
//  BWChatQuestionCell.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by Xiao Fu on 2024/5/16.
//

import Foundation
import UIKit

typealias BWChatQuestionCellHeightCallBack = (Double) -> ()
typealias BWChatQuestionCellQuestionClickCallBack = (QA) -> ()

class BWChatQuestionCell: UITableViewCell {
    var heightBlock: BWChatQuestionCellHeightCallBack?
    var clickBlock: BWChatQuestionCellQuestionClickCallBack?
    lazy var questionView: BWQuestionView = {
        let view = BWQuestionView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .black
        lab.lineBreakMode = .byTruncatingTail
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
    
    var consultId: Int32? {
        didSet {
            if consultId != nil && self.question == nil {
                getAutoReplay(consultId: consultId!, workId: workerId)
            }
        }
    }
    
    var question: QuestionModel?
    
    func getAutoReplay(consultId: Int32, workId: Int32) {
        print(consultId)
       //自动回复
        NetworkUtil.getAutoReplay(consultId: consultId, wId: workId) { success, model in
            if success {
                self.question = model
                if let autoReplyItem = model?.autoReplyItem {
                    print("--------" + (autoReplyItem.name ?? ""))
                    self.questionView.setup(model: model!)
                }
            }
        }
    }
    
    var model: ChatModel? {
        didSet {
            
            guard let msg = model?.message else { return }
           
            self.timeLab.text = WTimeConvertUtil.displayLocalTime(from: msg.msgTime.date)
        }
    }
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
        self.contentView.addSubview(self.timeLab)
        self.timeLab.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(12)
            make.right.equalToSuperview().offset(-12)
        }
        contentView.addSubview(questionView)
        
        questionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(210)
            make.height.equalTo(180)
            make.top.equalTo(timeLab.snp.bottom).offset(10)
        }
        
        questionView.heightCallback = { [weak self] (height: Double) in
            self?.questionView.snp.updateConstraints { make in
                make.height.equalTo(height)
            }
            self?.heightBlock!(height)
        }
        questionView.cellClick = { [weak self] (model: QA) in
            self?.clickBlock!(model)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
