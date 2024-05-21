//
//  KeFuViewController_ChatSDK.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by Xuefeng on 20/5/24.
//

import Foundation
import TeneasyChatSDK_iOS


extension KeFuViewController: teneasySDKDelegate {
    
    func initSDK(baseUrl: String) {
        let wssUrl = "wss://" + baseUrl + "/v1/gateway/h5?"
        // 第一次cert必填，之后token必填
        lib = ChatLib(userId: userId, cert: cert, token: xToken, baseUrl: wssUrl, sign: "9zgd9YUc")
        
        lib.callWebsocket()
        lib.delegate = self
    }
    
    public func receivedMsg(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("receivedMsg")
        appendDataSource(msg: msg, isLeft: true)
        
        scrollToBottom()
    }
    
    public func msgDeleted(msg: TeneasyChatSDK_iOS.CommonMessage, payloadId: UInt64, errMsg: String?) {

    }
    
    public func msgReceipt(msg: TeneasyChatSDK_iOS.CommonMessage, payloadId: UInt64, errMsg: String?) {
        print("msgReceipt" + WTimeConvertUtil.displayLocalTime(from: msg.msgTime.date))
        // 通过payloadId从DataSource里面找对应记录，并更新状态和时间
        print("------\(payloadId)")
        let index = datasouceArray.firstIndex { model in
            model.payLoadId == payloadId
        }
        if (index ?? -1) > -1 {
            if msg.msgID == 0 {
                datasouceArray[index!].sendStatus = .发送失败
                print("状态更新 -> 发送失败")
            } else {
                datasouceArray[index!].sendStatus = .发送成功
                datasouceArray[index!].message = msg
                print(msg.msgID)
                print("状态更新 -> 发送成功")
            }

            tableView.reloadRows(at: [IndexPath(row: index!, section: 0)], with: UITableView.RowAnimation.automatic)
        }

        let arr = datasouceArray.filter { modal in modal.message.msgID == 0 && modal.isLeft == false }
        for p in arr {
            print(p.message.msgID)
            p.sendStatus = .发送失败
            tableView.reloadData()
        }
        scrollToBottom()
    }

    public func systemMsg(result: TeneasyChatSDK_iOS.Result) {
        print("systemMsg")
        print(result.Message)
        if result.Code == 1002 || result.Code == 1010{
            WWProgressHUD.showInfoMsg(result.Message)
            navigationController?.popToRootViewController(animated: true)
        }
    }


    public func workChanged(msg: Gateway_SCWorkerChanged) {
        consultId = msg.consultID
        print(msg.workerName)
    }
    
    
    public func connected(c: Gateway_SCHi) {
        xToken = c.token
        UserDefaults.standard.set(c.token, forKey: PARAM_XTOKEN)
        // loadWorker(workerId: c.workerID)
         WWProgressHUD.showLoading("连接中...")
         print("assign work")
         NetworkUtil.assignWorker(consultId: CONSULT_ID) { [weak self]success, model in
             if success {
                 print("assign work 成功")
                 self?.updateWorker(workerName: model?.nick ?? "", avatar: model?.avatar ?? "")
                 
                 NetworkUtil.getHistory(consultId: CONSULT_ID) { success, data in
                     //print(data)
                     //构建本地消息
                     self?.buildHistory(history:  data ?? HistoryModel())
                 }
             }
             WWProgressHUD.dismiss()
         }
    }
    
    //产生一个本地文本消息
    func composeALocalTxtMessage(textMsg: String) -> CommonMessage {
        // 第一层
        var content = CommonMessageContent()
        content.data = textMsg
        
        // 第二层, 消息主题
        var msg = CommonMessage()
        msg.content = content
        msg.sender = 0
        msg.chatID = 0
        msg.payload = .content(content)
        msg.worker = 0
        msg.msgTime.seconds = Int64(Date().timeIntervalSince1970)
        
        return msg
    }
    
    //产生一个本地图片消息
    func composeALocalImgMessage(url: String) -> CommonMessage {
        // 第一层
        var content = CommonMessageImage()
        content.uri = url
        
        // 第二层, 消息主题
        var msg = CommonMessage()
        msg.consultID = self.consultId
        msg.image = content
        msg.sender = 0

        msg.chatID = 0
        msg.payload = .image(content)
        msg.worker = 0
        msg.msgTime.seconds = Int64(Date().timeIntervalSince1970)
        
        return msg
    }
}
