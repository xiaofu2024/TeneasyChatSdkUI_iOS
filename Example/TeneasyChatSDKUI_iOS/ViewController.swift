//
//  ViewController.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by 7938813 on 01/30/2023.
//  Copyright (c) 2023 7938813. All rights reserved.
//

import TeneasyChatSDK_iOS
// import TeneasyChatSDKUI_iOS
import UIKit

class ViewController: UIViewController, teneasySDKDelegate {
    /// 输入框工具栏
    lazy var toolBar: BWKeFuChatToolBar = {
        let toolBar = BWKeFuChatToolBar()
        toolBar.delegate = self
        return toolBar
    }()
    
    var lib = ChatLib()

    override func viewDidLoad() {
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initSDK() {
        // 从网页端把chatId和token传进sdk,
        lib = ChatLib(chatId: 2692944494602,
                      token: "CCcQARgKIBwotaa8vuAw.TM241ffJsCLGVTPSv-G65MuEKXuOcPqUKzpVtiDoAnOCORwC0AbAQoATJ1z_tZaWDil9iz2dE4q5TyIwNcIVCQ")
        lib.callWebsocket()
        lib.delegate = self
    }
    
    @objc func test() {
        let txtMsg = "测试一下"
        lib.sendMessage(msg: txtMsg)
        let c = CommonMessage()
        print(c.content)
    }
    
    func receivedMsg(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("receivedMsg")
        print(msg)
        switch msg.payload {
        case .content(msg.content):
            print("text")
//            appendMsg(msg: msg.content.data)
        case .image(msg.image):
            print(msg.image)
//            appendMsg(msg: "图片：" + msg.image.uri)
        case .video(msg.video):
            print("video")
        case .audio(msg.audio):
            print("audio")
        default:
            print("ddd")
        }
    }
    
    func msgReceipt(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("msgReceipt")
    }
    
    func systemMsg(msg: String) {
        print("systemMsg")
    }
    
    func connected(c: Bool) {
        print("connected")
        print(c)
    }
}

extension ViewController: BWKeFuChatToolBarDelegate {
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedVoice btn: UIButton) {}

    /// 菜单/发送
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedMenu btn: UIButton) {
//        self.scorllShow = true
//        viewModel.scrollToBottom()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            //此处写要延迟的东西
//            self.scorllShow = false
//        }
    }

    /// 表情
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedEmoji btn: UIButton) {
//        self.scorllShow = true
//        viewModel.scrollToBottom()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            //此处写要延迟的东西
//            self.scorllShow = false
//        }
    }

    /// 录音
    func toolBar(toolBar: BWKeFuChatToolBar, sendVoice gesture: UILongPressGestureRecognizer) {}

    /// 图片或视频
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedPhoto btn: UIButton) {
//        WImageUtil.showPhotoVender(vc: self) { assets, isOriginal in
//            self.viewModel.addTimeMessage()
//            self.viewModel.uploadImageOfVideo(assets: assets, isOrginl: isOriginal)
//        }
        self.toolBar.resetStatus()
    }

    func toolBar(toolBar: BWKeFuChatToolBar, menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {}
    
    func toolBar(toolBar: BWKeFuChatToolBar, didBeginEditing textView: UITextView) {
//        setFloatBtnHidden()
//        viewModel.scrollToBottom()
//        if textView.text.length > 0 {
//            sending = true
//            viewModel.sendInputPrompt()
//        }
    }
    
    func toolBar(toolBar: BWKeFuChatToolBar, didChanged textView: UITextView) {
//        if textView.attributedText.length > 0 {
//            if !sending {
//                sending = true
//                viewModel.sendInputPrompt()
//            }
//        }
//        else {
//            sending = false
//            viewModel.sendInputPrompt("")
//        }
    }

    func toolBar(toolBar: BWKeFuChatToolBar, didEndEditing textView: UITextView) {
//        sending = false
//        viewModel.sendInputPrompt("")
    }
    
    /// 发送文字
    func toolBar(toolBar: BWKeFuChatToolBar, sendText context: String) {
//        sending = false
//        Timer.after(0.5) {
//            return
//        }
//
//        toolBar.textView.text = ""
//        toolBar.savedText = NSAttributedString(string:"")
//        if context == ""{
//            return
//        }
//        if context.isMatch("^[\\s]*$"){
//            toolBar.resetStatus()
//            WAlerViewManager.showNologo(parentView: nil, title: "提示",description: "不能发送空白消息",cancelBtnTitle: nil) {
//
//            }
//            return
//        }
//
//        if self.viewModel.replyOriginChatModel == nil {
//            self.viewModel.addTimeMessage()
//            let newText = WSplashVM.shared.filterSenstiveWord(text: context)
//            self.viewModel.sendMessage(messageType: .text, content: newText, aiteInfo: aiTeInfos, voiceDuration: 0, toNimId: "",object: "nil")
//            aiTeInfos = []
//        }
//        else {
//            self.viewModel.addTimeMessage()
//            self.viewModel.sendMessage(messageType: .replyText, content: context, aiteInfo: aiTeInfos, voiceDuration: 0, toNimId: "",object: "nil")
//            aiTeInfos = []
        ////            //回复框隐藏
        ////            self.hideReplyBar()
//        }
//        self.viewModel.sendInputPrompt("")
    }
    
    @objc func toolBar(toolBar: BWKeFuChatToolBar, delete text: String, range: NSRange) -> Bool {
        return true
    }
    
    @objc func toolBar(toolBar: BWKeFuChatToolBar, changed text: String, range: NSRange) -> Bool {
        return true
    }
}
