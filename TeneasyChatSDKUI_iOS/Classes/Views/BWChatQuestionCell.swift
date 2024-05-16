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
                getAutoReplay(consultId: consultId!)
            }
        }
    }
    
    var question: QuestionModel?
    
    func getAutoReplay(consultId: Int32) {
        print(consultId)
        XToken = "COYBEAUYASDyASiG2piD9zE.te46qua5ha2r-Caz03Vx2JXH5OLSRRV2GqdYcn9UslwibsxBSP98GhUKSGEI0Z84FRMkp16ZK8eS-y72QVE2AQ"
        NetworkUtil.getAutoReplay(consultId: consultId) { success, model in
            if success {
                self.question = model
                if let autoReplyItem = model?.autoReplyItem {
                    print("--------" + (autoReplyItem.name ?? ""))
                    self.questionView.setup(model: model!)
                }
            }
        }
    }
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
                
        contentView.addSubview(questionView)
        
        questionView.snp.makeConstraints { make in
            make.left.equalToSuperview()
            make.width.equalTo(kScreenWidth - 24)
            make.height.equalTo(30)
            make.top.equalToSuperview()
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
