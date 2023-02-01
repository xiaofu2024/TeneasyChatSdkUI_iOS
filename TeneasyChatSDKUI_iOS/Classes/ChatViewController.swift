//
//  ChatViewController.swift
//  TeneasyChatSDK_iOS
//
//  Created by XiaoFu on 01/19/2023.
//  Copyright (c) 2023 XiaoFu. All rights reserved.
//

import TeneasyChatSDK_iOS
// import TeneasyChatSDKUI_iOS
import UIKit

open class ChatViewController: UIViewController, teneasySDKDelegate {
    /// 输入框工具栏
    lazy var toolBar: BWKeFuChatToolBar = {
        let toolBar = BWKeFuChatToolBar()
        toolBar.delegate = self
        return toolBar
    }()

    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .groupTableViewBackground
        view.separatorStyle = .none
        /// 设置tableview 顶部间距
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: 10))
        view.tableHeaderView = footerView
        view.estimatedRowHeight = 50
        view.rowHeight = UITableViewAutomaticDimension
        return view
    }()

    var datasouceArray: [ChatModel] = []

    var lib = ChatLib()

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kBgColor

        initSDK()
        initView()
    }

    func initView() {
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kDeviceBottom)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalTo(toolBar.snp.top)
        }
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initSDK() {
        // 从网页端把chatId和token传进sdk,
        lib = ChatLib(chatId: 2692944494602,
                      token: "CCcQARgKIBwotaa8vuAw.TM241ffJsCLGVTPSv-G65MuEKXuOcPqUKzpVtiDoAnOCORwC0AbAQoATJ1z_tZaWDil9iz2dE4q5TyIwNcIVCQ")
        lib.callWebsocket()
        lib.delegate = self
    }

    public func receivedMsg(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("receivedMsg")
        appendDataSource(msg: msg, isLeft: true)
    }

    public func msgReceipt(msg: CommonMessage) {
        print("msgReceipt")
        appendDataSource(msg: msg, isLeft: false)
    }

    func appendDataSource(msg: CommonMessage, isLeft: Bool) {
        let model = ChatModel()
        model.isLeft = isLeft
        model.message = msg
        datasouceArray.append(model)
        tableView.reloadData()
    }

    public func systemMsg(msg: String) {
        print("systemMsg")
    }

    public func connected(c: Bool) {
        print("connected")
    }
}

extension ChatViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datasouceArray[indexPath.row]
        if model.isLeft {
            let cell = BWChatLeftCell.cell(tableView: tableView)
            cell.model = model
            return cell
        }
        let cell = BWChatRightCell.cell(tableView: tableView)
        cell.model = model
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasouceArray.count
    }
}

extension ChatViewController: BWKeFuChatToolBarDelegate {
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedVoice btn: UIButton) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedMenu btn: UIButton) {}

    /// 表情
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedEmoji btn: UIButton) {}

    /// 录音
    func toolBar(toolBar: BWKeFuChatToolBar, sendVoice gesture: UILongPressGestureRecognizer) {}

    /// 点击发送或者图片
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedPhoto btn: UIButton) {
        if btn.titleLabel?.text == "发送" {
            sendMsg(context: toolBar.textView.text)
        } else {
            // 选图片
        }
        self.toolBar.resetStatus()
    }

    func sendMsg(context: String) {
        lib.sendMessage(msg: context)
    }
    
    func sendImage(context: String) {
        lib.sendMessageImage(url: "https://www.bing.com/th?id=OHR.SunriseCastle_ROW9509100997_1920x1080.jpg&rf=LaDigue_1920x1080.jpg")
    }

    func toolBar(toolBar: BWKeFuChatToolBar, menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didBeginEditing textView: UITextView) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didChanged textView: UITextView) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didEndEditing textView: UITextView) {}

    /// 发送文字
    func toolBar(toolBar: BWKeFuChatToolBar, sendText context: String) {
        sendMsg(context: context)
    }

    @objc func toolBar(toolBar: BWKeFuChatToolBar, delete text: String, range: NSRange) -> Bool {
        return true
    }

    @objc func toolBar(toolBar: BWKeFuChatToolBar, changed text: String, range: NSRange) -> Bool {
        return true
    }
}
