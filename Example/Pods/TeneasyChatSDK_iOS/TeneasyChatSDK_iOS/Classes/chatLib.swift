import Foundation
import Starscream
import SwiftProtobuf
import UIKit
// import Toast

// https://swiftpackageregistry.com/daltoniam/Starscream
// https://www.kodeco.com/861-websockets-on-ios-with-starscream
public protocol teneasySDKDelegate : AnyObject{
    // func receivedMsg(msg: String)
    func receivedMsg(msg: CommonMessage)
    func msgReceipt(msg: CommonMessage, payloadId: UInt64)
    func systemMsg(msg: String)
    func connected(c: Gateway_SCHi)
    func workChanged(msg: Gateway_SCWorkerChanged)
}

/*
 extension teneasySDKDelegate {
     func receivedMsg2(msg: EasyMessage) {
         /* return a default value or just leave empty */
     }
 }*/

open class ChatLib {
    public private(set) var text = "Teneasy Chat SDK 启动"
    var baseUrl = "wss://csapi.xdev.stream/v1/gateway/h5?token="
    var websocket: WebSocket?
    var isConnected = false
    // weak var delegate: WebSocketDelegate?
    public weak var delegate: teneasySDKDelegate?
    open var payloadId: UInt64? = 0
    public var sendingMsg: CommonMessage?
    var chatId: Int64? = 0
    var token: String? = ""
    var session = Session()
    
    var myTimer: Timer?
    var sessionTime: Int = 0
    var chooseImg: UIImage?
    var beatTimes = 0
    var maxSessionMinutes = 30
    
    public init() {}

    public init(chatId: Int64, token: String) {
        self.chatId = chatId
        self.token = token
        beatTimes = 0
        print(text)
    }
    
    public init(session: Session) {
        self.session = session
    }

    public func callWebsocket() {
        // var request = URLRequest(url: URL(string: baseUrl))
        let request = URLRequest(url: URL(string: baseUrl + token!)!)
        // request.setValue("chat,superchat", forHTTPHeaderField: "Sec-WebSocket-Protocol")
        websocket = WebSocket(request: request)
        websocket?.request.timeoutInterval = 5 // Sets the timeout for the connection
        websocket?.delegate = self
        websocket?.connect()
         
        /* 添加header的办法
         request.setValue("someother protocols", forHTTPHeaderField: "Sec-WebSocket-Protocol")
         request.setValue("14", forHTTPHeaderField: "Sec-WebSocket-Version")
         request.setValue("chat,superchat", forHTTPHeaderField: "Sec-WebSocket-Protocol")
         request.setValue("Everything is Awesome!", forHTTPHeaderField: "My-Awesome-Header")
         */
        startTimer()
        print("call web socket")
    }
    
    public func reConnect(){
        if websocket != nil{
            websocket?.connect()
        }
    }
    
    deinit {
        disConnect()
    }
    
    func startTimer() {
       stopTimer()
        myTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updataSecond), userInfo: nil, repeats: true)
        myTimer!.fire()
    }

    
    @objc func updataSecond() {
        sessionTime += 1
        if sessionTime%5 == 0{//每隔8秒发送一个心跳
            beatTimes += 1
            print("sending beat \( beatTimes)")
            sendHeartBeat()
        }
        
        if sessionTime > maxSessionMinutes * 60{//超过最大会话，停止发送心跳
            stopTimer()
        }
    }

    func stopTimer() {
        if myTimer != nil {
            myTimer!.invalidate() // 销毁timer
            myTimer = nil
        }
    }
    
    public func deleteMessage() {}
    
    public func sendMessage(msg: String) {
        // 发送信息的封装，有四层
        // payload -> CSSendMessage -> common message -> CommonMessageContent
        
        // 第一层
        var content = CommonMessageContent()
        content.data = msg
        
        // 第二层, 消息主题
        var msg = CommonMessage()
        msg.content = content
        msg.sender = 0
        msg.chatID = chatId!
        msg.payload = .content(content)
        msg.worker = 5
        msg.msgTime.seconds = Int64(Date().timeIntervalSince1970)

        // 第三层
        var cSendMsg = Gateway_CSSendMessage()
        cSendMsg.msg = msg
        // Serialize to binary protobuf format:
        let cSendMsgData: Data = try! cSendMsg.serializedData()
        
        // 第四层
        var payLoad = Gateway_Payload()
        payLoad.data = cSendMsgData
        payLoad.act = .cssendMsg
        payloadId! += 1
        print("payloadID:" + String(payloadId!))
        payLoad.id = payloadId!
        let binaryData: Data = try! payLoad.serializedData()
        
        // 临时放到一个变量
        sendingMsg = msg
        
        send(binaryData: binaryData)
    }
    
    public func sendMessageImage(url: String) {
        // 发送信息的封装，有四层
        // payload -> CSSendMessage -> common message -> CommonMessageContent
        // 第一层
        var content = CommonMessageImage()
        content.uri = url
        
        // 第二层, 消息主题
        var msg = CommonMessage()
        msg.image = content
        msg.sender = 0
        msg.chatID = chatId!
        msg.payload = .image(content)
        msg.worker = 5
        msg.msgTime.seconds = Int64(Date().timeIntervalSince1970)

        // 第三层
        var cSendMsg = Gateway_CSSendMessage()
        cSendMsg.msg = msg
        // Serialize to binary protobuf format:
        let cSendMsgData: Data = try! cSendMsg.serializedData()
        
        // 第四层
        var payLoad = Gateway_Payload()
        payLoad.data = cSendMsgData
        payLoad.act = .cssendMsg
        payloadId! += 1
        
        // self.payloadId! += Int64.random(in: 1000...19999)
        let bigUInt = UInt64(payloadId!)
        payLoad.id = bigUInt
        let binaryData: Data = try! payLoad.serializedData()
        
        // 临时放到一个变量
        sendingMsg = msg
        
        send(binaryData: binaryData)
    }
    
    public func resendMsg(msg: CommonMessage, payloadId: Int) {
        // 第三层
        var cSendMsg = Gateway_CSSendMessage()
        cSendMsg.msg = msg
        // Serialize to binary protobuf format:
        let cSendMsgData: Data = try! cSendMsg.serializedData()
        
        // 第四层
        var payLoad = Gateway_Payload()
        payLoad.data = cSendMsgData
        payLoad.act = .cssendMsg
        self.payloadId! = UInt64(payloadId)
        payLoad.id = self.payloadId!
        let binaryData: Data = try! payLoad.serializedData()
        
        // 临时放到一个变量
        sendingMsg = msg
        
        send(binaryData: binaryData)
    }
    
    public func sendHeartBeat() {
//        var myInt = 0
//        let myIntData = Data(bytes: &myInt,
//                             count: MemoryLayout.size(ofValue: myInt))
        
        let array: [UInt8] = [0]

        let myData = Data(bytes: array)
        send(binaryData: myData)
        print("sending heart beat")
    }
    
    private func send(binaryData: Data) {
        if !isConnected {
            print("断开了")
            if sessionTime > maxSessionMinutes * 60 {
                delegate?.systemMsg(msg: "会话超过30分钟，需要重新进入")
                failedToSend()
            } else {
                callWebsocket()
                delegate?.systemMsg(msg: "断开了，重新连接。。。")
                failedToSend()
            }
        } else {
            if sessionTime > maxSessionMinutes * 60 {
                delegate?.systemMsg(msg: "会话超过30分钟，需要重新进入")
                failedToSend()
            } else {
                websocket?.write(data: binaryData, completion: ({
                    print("msg sent")
                }))
            }
        }
    }
    
    private func failedToSend(){
        if sendingMsg != nil{
            delegate?.msgReceipt(msg: sendingMsg!, payloadId: payloadId!)
        }
    }
    
    public func disConnect() {
        stopTimer()
        if websocket != nil {
            websocket!.disconnect()
            websocket!.delegate = nil
            websocket = nil
        }
        print("通信SDK 断开连接")
    }
    
    private func serilizeSample() {
        var info = CommonPhoneNumber()
        info.countryCode = 65
        info.nationalNumber = 99999
        
        // Serialize to binary protobuf format:
        let binaryData: Data = try! info.serializedData()

        // Deserialize a received Data object from `binaryData`
        let decodedInfo = try? CommonPhoneNumber(serializedData: binaryData)

        // Serialize to JSON format as a Data object
        let jsonData: Data = try! info.jsonUTF8Data()

        // Deserialize from JSON format from `jsonData`
        let receivedFromJSON = try! CommonPhoneNumber(jsonUTF8Data: jsonData)
    }
}

// MARK: - WebSocketDelegate

extension ChatLib: WebSocketDelegate {
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("got some text: \(text)")
    }

    public func didReceive(event: WebSocketEvent, client: WebSocket) {
        switch event {
        case .connected:
            // print("connected" + headers.description)
            delegate?.systemMsg(msg: "已连接上")
//           if sendingMsg != nil{
//               self.sendMessage(msg: sendingMsg!.content.data)
//           }
            isConnected = true
        case .disconnected(let reason, let closeCode):
            print("disconnected \(reason) \(closeCode)")
            isConnected = false
            failedToSend()
        case .text(let text):
            print("received text: \(text)")
        case .binary(let data):
            if data.count == 1 {
                print("在别处登录了")
                if let d = String(data: data, encoding: .utf8) {
                    if d.contains("2") {
                        delegate?.systemMsg(msg: "无效的Token")
                    } else {
                        delegate?.systemMsg(msg: "在别处登录了")
                    }
                    print(d)
                    isConnected = false
                }
                
            } else {
                let payLoad = try? Gateway_Payload(serializedData: data)
                let msgData = payLoad?.data
                payloadId = payLoad?.id

                print("payloadID:" + String(payloadId!))
               
                if payLoad?.act == .screcvMsg {
                    let msg = try? Gateway_SCRecvMessage(serializedData: msgData!)
                    if let msC = msg?.msg {
                        delegate?.receivedMsg(msg: msC)
                    }
                } else if payLoad?.act == .schi { // 连接成功后收到的信息，会返回clientId, Token
                    if let msg = try? Gateway_SCHi(serializedData: msgData!) {
                        print("chatID:" + String(msg.id))
                        delegate?.connected(c: msg)
                        print(msg)
                    }
                } else if payLoad?.act == .scworkerChanged {
                    if let msg = try? Gateway_SCWorkerChanged(serializedData: msgData!) {
                        delegate?.workChanged(msg: msg)
                        print(msg)
                    }
                }
               
                /*
                 sendInputtingBegin(msg) {
                        const data = gateway.Payload.create({
                            act: gateway.Action.ActionInputtingBegin,
                            data: gateway.InputtingBegin.encode(msg).finish()
                        });
                        this.ev.onSend.emit(data);
                    }
                    ;
                    sendInputtingEnd(msg) {
                        const data = gateway.Payload.create({
                            act: gateway.Action.ActionInputtingEnd,
                            data: gateway.InputtingEnd.encode(msg).finish()
                        });
                        this.ev.onSend.emit(data);
                    }
                    ;
                 */
               
                else if payLoad?.act == .forward {
                    let msg = try? Gateway_CSForward(serializedData: msgData!)
                    print(msg!)
                } else if payLoad?.act == .scsendMsgAck { // 服务器告诉此条信息是否发送成功
                    if let scMsg = try? Gateway_SCSendMessage(serializedData: msgData!) {
                        print("消息回执")
                        if sendingMsg != nil {
                            sendingMsg?.msgID = scMsg.msgID // 发送成功会得到消息ID
                            sendingMsg?.msgTime = scMsg.msgTime
                         
                            delegate?.msgReceipt(msg: sendingMsg!, payloadId: payLoad!.id)
                            print(scMsg)
                            sendingMsg = nil
                        }
                    }
                } else {
                    print("received data: \(data)")
                }
            }

        case .pong(let pongData):
            print("received pong: \(pongData)")
        case .ping(let pingData):
            print("received ping: \(pingData)")
        case .error(let error):
            // self.delegate?.connected(c: false)
            print("socket error \(error)")
            delegate?.systemMsg(msg: "Socket 出错")
            failedToSend()
            isConnected = false
        case .viabilityChanged:
            print("viabilityChanged")
        case .reconnectSuggested:
            print("reconnectSuggested")
        case .cancelled:
            delegate?.systemMsg(msg: "已取消连接")
            failedToSend()
            print("cancelled")
            isConnected = false
        }
    }
    
    public func composeMessage(textMsg: String) -> CommonMessage {
        // 第一层
        var content = CommonMessageContent()
        content.data = textMsg
        
        // 第二层, 消息主题
        var msg = CommonMessage()
        msg.content = content
        msg.sender = 0
        msg.chatID = chatId!
        msg.payload = .content(content)
        msg.worker = 5
        msg.msgTime.seconds = Int64(Date().timeIntervalSince1970)
        
        return msg
    }
    /* public func toastHello(vc : UIViewController){
         let alert = UIAlertController(title: "你好", message: "Message", preferredStyle: UIAlertController.Style.actionSheet)
         alert.addAction(UIAlertAction(title: "Click", style: UIAlertAction.Style.default, handler: { _ in
           
         }))
         vc.present(alert, animated: true, completion: nil)
     } */
}
