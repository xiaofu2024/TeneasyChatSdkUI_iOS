//
//  ViewController.swift
//  TeneasyChatSDK_iOS
//
//  Created by XiaoFu on 01/19/2023.
//  Copyright (c) 2023 XiaoFu. All rights reserved.
//

import UIKit
import TeneasyChatSDK_iOS
import SnapKit


open class ChatViewController: UIViewController, teneasySDKDelegate {

    lazy var tvChatView: UITextView = {
        let tv = UITextView()
        return tv
    }()
    
    
    var lib = ChatLib()
 public func receivedMsg(msg: CommonMessage) {
        print(msg)
       
        switch msg.payload{
        case .content(msg.content):
            print("text")
            appendMsg(msg: msg.content.data)
        case .image(msg.image):
            print(msg.image)
            appendMsg(msg: "图片：" + msg.image.uri)
        case .video(msg.video):
            print("video")
        case .audio(msg.audio):
            print("audio")
        default:
            print("ddd")
        }
    }
    
    public   func connected(c: Bool) {
        if c == true{
            tvChatView.text.append("\n已连接上！\n\n")
        }else{
            //tvChatView.text.append("\n已断开连接\n\n")
            //tvChatView.text.append("\n重新连接\n")
            initSDK()
        }
    }
    
    public  func msgReceipt(msg: CommonMessage){
        tvChatView.text.append("                       " +  msg.content.data)
        if msg.msgID == 0{
            tvChatView.text.append("                    发送失败")
        }
      
        tvChatView.text.append("                                         " +  Date().getFormattedDate(format: "HH:mm:ss") + "\n\n")
    }
    
    public  func systemMsg(msg: String){
        appendMsg(msg: msg)
    }
    
    public  func appendMsg(msg: String){
        tvChatView.text.append(msg + "\n" +  Date().getFormattedDate(format: "HH:mm:ss") + "\n\n")
        //cpf
    }
    
   
    open override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(tvChatView)
        tvChatView.snp.makeConstraints { make in
            make.left.equalTo(10)
            make.top.equalTo(50)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-50)
        }
        
        tvChatView.text = "teneasy chat sdk 初始化"
        tvChatView.isUserInteractionEnabled = true
        tvChatView.isScrollEnabled = true
        
        initSDK()
    }
    
    func initSDK(){
        //从网页端把chatId和token传进sdk,
        lib = ChatLib(chatId: 2692944494601, token: "CCcQARgJICIon6WAieAw.4hI0uHGRO_-CSlDFnI4036IVnXr7No1wF9f32TCvDXFj27Ph4migozWYC6348C3bvvM-kbdZDAqSNIG2BiAYDw")
        lib.callWebsocket()
        lib.delegate = self
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        let btSend = UIButton()
        btSend.frame = CGRect(x: 100, y: 600, width: 200, height: 200)
        btSend.setTitleColor(UIColor.systemRed, for: UIControl.State.normal)
        btSend.setTitle("Send", for: UIControl.State.normal)
        self.view.addSubview(btSend)
        btSend.addTarget(self, action:#selector(btSendAction), for:.touchUpInside)
    }
    
    @objc func btSendAction(){
        let txtMsg = "你好！需要什么帮助？\n"
        lib.sendMessage(msg: txtMsg)
        let c = CommonMessage()
        print(c.content)
    }
    

    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

