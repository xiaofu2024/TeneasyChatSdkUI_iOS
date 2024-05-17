//
//  ChatViewController.swift
//  TeneasyChatSDK_iOS
//
//  Created by XiaoFu on 01/19/2023.
//  Copyright (c) 2023 XiaoFu. All rights reserved.
//

import Alamofire
import Network
import PhotosUI
import TeneasyChatSDK_iOS
// import TeneasyChatSDKUI_iOS
import UIKit

open class KeFuViewController: UIViewController, teneasySDKDelegate {
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
        if result.Message == "已取消连接" {
            WWProgressHUD.dismiss()
        }
    }

    //open var token = "" // 起信Token
    // open var token = "CCcQARgCIBwo6_7VjN8w.Pa47pIINpFETl5RxrpTPqLcn8RVBAWrGW_ogyzQipI475MLhNPFFPkuCNEtsYvabF9uXMKK2JhkbRdZArUK3DQ"
    var retryTimes = 0
    var consultId: Int64 = 0
    public func workChanged(msg: Gateway_SCWorkerChanged) {
        consultId = msg.consultID
        print(msg.workerName)
    }

    lazy var imagePickerController: UIImagePickerController = {
        let pick = UIImagePickerController()
        pick.delegate = self
        return pick
    }()

    lazy var headerView: UIView = {
        let v = UIView(frame: CGRect.zero)
        v.backgroundColor = .white
        return v
    }()

    lazy var systemInfoView: UIView = {
        let v = UIView(frame: CGRect.zero)
        return v
    }()

    lazy var timeLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()

    lazy var systemMsgLabel: UILabel = {
        let label = UILabel(frame: CGRect.zero)
        label.textAlignment = .center
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13)
        return label
    }()

    lazy var headerImg: UIImageView = {
        let img = UIImageView(frame: CGRect.zero)
        img.layer.cornerRadius = 25
        img.layer.masksToBounds = true
        img.image = UIImage.svgInit("com_moren")
        return img
    }()

    lazy var headerClose: UIButton = {
        let btn = UIButton(frame: CGRect.zero)
        btn.setImage(UIImage.svgInit("close", size: CGSize(width: 20, height: 20)), for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(closeClick), for: UIControl.Event.touchUpInside)
        return btn
    }()

    lazy var headerTitle: UILabel = {
        let v = UILabel(frame: CGRect.zero)
        v.text = "--"
        return v
    }()

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
        view.estimatedRowHeight = 50
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

//    lazy var questionView: BWQuestionView = {
//        let view = BWQuestionView()
//        view.backgroundColor = .white
//        view.layer.cornerRadius = 8
//        view.layer.masksToBounds = true
//        return view
//    }()
    var questionViewHeight: Double = 0

    var datasouceArray: [ChatModel] = []

    var lib = ChatLib()
    var chooseImg: UIImage?

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kBgColor
        
        //
        xToken = ""

        initSDK(baseUrl: domain)
        initView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        let leftBarItem = UIBarButtonItem(title: "", style: .done, target: self, action: nil)
        navigationItem.leftBarButtonItem = leftBarItem
        // self.navigationItem.setHidesBackButton(true, animated: false)
//
        let rightBarItem = UIBarButtonItem(title: "退出", style: .done, target: self, action: #selector(quit))
        navigationItem.rightBarButtonItem = rightBarItem

//        getAutoReplay(consultId: Int32(consultId))
    }

    @objc func closeClick() {
        dismiss(animated: true)
    }

    override open func viewDidDisappear(_ animated: Bool) {
//        lib.disConnect()
    }

    @objc func quit() {
        lib.disConnect()
        lib.delegate = nil
        navigationController?.popToRootViewController(animated: true)
    }

    func initView() {
        view.addSubview(toolBar)
        toolBar.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-kDeviceBottom)
        }

        view.addSubview(headerView)
        headerView.snp.makeConstraints { make in
            make.width.equalTo(kScreenWidth)
            make.height.equalTo(60)
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(kDeviceTop)
        }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(self.headerView.snp.bottom)
            make.bottom.equalTo(toolBar.snp.top)
        }

        headerView.addSubview(headerImg)
        headerImg.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.left.equalToSuperview().offset(12)
            make.top.equalToSuperview().offset(5)
        }
        headerView.addSubview(headerTitle)
        headerTitle.snp.makeConstraints { make in
            make.centerY.equalTo(self.headerImg.snp.centerY)
            make.left.equalTo(self.headerImg.snp.right).offset(12)
        }
        headerView.addSubview(headerClose)
        headerClose.snp.makeConstraints { make in
            make.centerY.equalTo(self.headerImg.snp.centerY)
            make.right.equalToSuperview().offset(-16)
        }
        tableView.tableHeaderView = systemInfoView

        systemInfoView.addSubview(timeLabel)
        systemInfoView.snp.makeConstraints { make in
            make.width.equalTo(kScreenWidth - 24)
            make.leading.equalTo(12)
            make.top.equalToSuperview().offset(12)
        }
        timeLabel.snp.makeConstraints { make in
            make.width.equalTo(kScreenWidth)
            make.left.equalToSuperview()
            make.top.equalToSuperview().offset(6)
        }
        systemInfoView.addSubview(systemMsgLabel)
        systemMsgLabel.snp.makeConstraints { make in
            make.width.equalTo(kScreenWidth)
            make.left.equalToSuperview()
            make.top.equalTo(self.timeLabel.snp.bottom)
        }
//        systemInfoView.addSubview(questionView)
//        questionView.snp.makeConstraints { make in
//            make.left.equalToSuperview()
//            make.width.equalTo(kScreenWidth-24)
//            make.height.equalTo(30)
//            make.top.equalTo(systemMsgLabel.snp.bottom)
//            make.bottom.equalToSuperview()
//        }
//
//        questionView.heightCallback = {[weak self] (height: Double) in
//            self?.questionView.snp.updateConstraints({ make in
//                make.height.equalTo(height)
//            })
//            self?.systemInfoView.frame.size.height = height + 30
//            self?.tableView.reloadData()
//        }
//        questionView.cellClick = {[weak self] (model: QA) in
//            self?.sendMsg(textMsg: model.question?.content?.data ?? "")
//
//            let msg = self?.lib.composeALocalMessage(textMsg: model.content ?? "")
//            if (msg != nil) {
//                self?.appendDataSource(msg: msg!, isLeft: true)
//            }
//        }

        toolBar.textView.placeholder = "请输入想咨询的问题"
        headerTitle.text = "连接客服中..."
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func initSDK(baseUrl: String) {
        let wssUrl = "wss://" + baseUrl + "/v1/gateway/h5?"
        // 第一次cert必填，之后token必填
        lib = ChatLib(userId: 1125324, cert: cert, token: xToken, baseUrl: wssUrl, sign: "9zgd9YUc")

        lib.callWebsocket()
        lib.delegate = self
    }

    public func receivedMsg(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("receivedMsg")
        appendDataSource(msg: msg, isLeft: true)

        scrollToBottom()
    }

    func scrollToBottom() {
        if datasouceArray.count > 1 {
            tableView.scrollToRow(at: IndexPath(row: datasouceArray.count - 1, section: 0), at: UITableView.ScrollPosition.none, animated: true)
        }
    }

    func appendDataSource(msg: CommonMessage, isLeft: Bool, payLoadId: UInt64 = 0) {
        let model = ChatModel()
        model.isLeft = isLeft
        model.message = msg
        model.payLoadId = payLoadId
        if !isLeft {
            model.sendStatus = .发送中
        }
        datasouceArray.append(model)
        tableView.reloadData()
    }

    public func systemMsg(msg: String) {
        print("systemMsg")
        print(msg)
        // self.timeLabel.text = Date().dataWithFormat(fmtString: "MM/dd/yyyy HH:mm:ss")
        timeLabel.text = WTimeConvertUtil.displayLocalTime(from: Date())
        systemMsgLabel.text = msg
    }

    public func connected(c: Gateway_SCHi) {
        print("work id \(c.workerID)")
        
        ///to do: save it to userdefault
        xToken = c.token
        if c.workerID == 0, retryTimes < 3 { // 如果没有分配到客服
            lib.callWebsocket() // 重新连接
            print("尝试重新连接")
            retryTimes += 1
        } else {
           // loadWorker(workerId: c.workerID)
            WWProgressHUD.showLoading("连接中...")
            print("assign work")
            NetworkUtil.assignWorker(consultId: CONSULT_ID) { [weak self]success, model in
                if success {
                    print("assign work 成功")
                    self?.updateWorker(workerName: model?.nick ?? "", avatar: model?.avatar ?? "")
                }
                WWProgressHUD.dismiss()
            }
        }
    }


//    func getAutoReplay(consultId: Int32) {
//        print(consultId)
//        XToken = "COYBEAEYCyDwASjC-N6t9TE.W0AyuCoZQmqOBrxBvh88pcvgKzxebPqrubASBGzWDNPZu4EhSfyPDTH_Smym9PUYUWNh00NvMAEisZO-mAErCw"
//        NetworkUtil.getAutoReplay(consultId: consultId) { success, model in
//            if success {
//                if let autoReplyItem = model?.autoReplyItem {
//                    print("--------" + (autoReplyItem.name ?? ""))
//                    self.questionView.setup(model: model!)
//                }
//            }
//        }
//    }

    
    func updateWorker(workerName:String, avatar: String){
        self.headerTitle.text = workerName
        print("baseUrlImage:" + baseUrlImage)
        let url = baseUrlImage + avatar
        print("avatar:" + url)
        self.headerImg.kf.setImage(with: URL(string: url))
        
        var greetingMsg = lib.composeALocalMessage(textMsg: "我是客服\(workerName)，请问需要什么帮助")
        appendDataSource(msg: greetingMsg, isLeft: true)
    }

   /* func loadWorker(workerId: Int32) {

        NetworkUtil.getWorker(workerId: workerId) { success, model in
            if success {
                if let workName = model?.workerName {
                    self.headerTitle.text = workName
                }

                print("baseUrlImage:" + baseUrlImage)
                if model?.workerAvatar?.isEmpty == false, model?.workerAvatar != nil {
                    let url = baseUrlImage + model!.workerAvatar!
                    print("avatar:" + url)
                    self.headerImg.kf.setImage(with: URL(string: url))
                }
            } else {
                self.headerTitle.text = "起信客服"
            }
            let msg = self.lib.composeALocalMessage(textMsg: "你好，我是客服" + (model?.workerName ?? ""))
            self.appendDataSource(msg: msg, isLeft: true)
        }
    }*/
}

extension KeFuViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = datasouceArray[indexPath.row]
        if model.isLeft {
            // 什么时机显示cell，待定
            /*if indexPath.row == 0 {
                let cell = BWChatQuestionCell.cell(tableView: tableView)
                cell.model = model
                cell.consultId = Int32(self.consultId)
                cell.heightBlock = { [weak self] (height: Double) in
                    self?.questionViewHeight = height + 30
                    self?.tableView.reloadData()
                }
                cell.clickBlock = { [weak self] (model: QA) in
                    self?.sendMsg(textMsg: model.question?.content?.data ?? "")

                    let msg = self?.lib.composeALocalMessage(textMsg: model.content ?? "")
                    if msg != nil {
                        self?.appendDataSource(msg: msg!, isLeft: true)
                    }
                }
                return cell
            }*/
            let cell = BWChatLeftCell.cell(tableView: tableView)
            cell.model = model
            return cell
        }
        let cell = BWChatRightCell.cell(tableView: tableView)
        cell.model = model
        cell.resendBlock = { [weak self] _ in
            self?.datasouceArray[indexPath.row].sendStatus = .发送中
            self?.lib.resendMsg(msg: model.message, payloadId: model.payLoadId)
        }
        return cell
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasouceArray.count
    }

//    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//
//    }

    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = datasouceArray[indexPath.row]
        if model.isLeft && indexPath.row == 0 {
            return questionViewHeight
        }
        if model.message.image.uri.isEmpty == false {
            return 200.0
        }
        return 50.0
    }
}

extension KeFuViewController: BWKeFuChatToolBarDelegate {
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedVoice btn: UIButton) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedMenu btn: UIButton) {}

    /// 表情
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedEmoji btn: UIButton) {}

    /// 录音
    func toolBar(toolBar: BWKeFuChatToolBar, sendVoice gesture: UILongPressGestureRecognizer) {}

    /// 点击发送或者图片
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedPhoto btn: UIButton) {
        if btn.titleLabel?.text == "发送" {
            sendMsg(textMsg: toolBar.textView.normalText())

        } else {
            // 选图片
            chooseImgFunc()
        }
        self.toolBar.resetStatus()
    }

    func chooseImgFunc() {
        let alertVC = UIAlertController(title: "选择图片", message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        let alertAction1 = UIAlertAction(title: "从相册选择", style: .default, handler: { [weak self] _ in
            self?.authorize { state in
                if state == .restricted || state == .denied {
                    self?.presentNoauth(isPhoto: true)
                } else {
                    self?.presentImagePicker(controller: self?.imagePickerController ?? UIImagePickerController(), source: .photoLibrary)
                }
            }
        })
        alertVC.addAction(alertAction1)
        let alertAction2 = UIAlertAction(title: "拍照", style: .default, handler: { [weak self] _ in
            self?.authorizeCamaro { state in
                if state == .restricted || state == .denied {
                    DispatchQueue.main.async {
                        self?.presentNoauth(isPhoto: false)
                    }
                } else {
                    DispatchQueue.main.async {
                        self?.presentImagePicker(controller: self?.imagePickerController ?? UIImagePickerController(), source: .camera)
                    }
                }
            }
        })
        alertVC.addAction(alertAction2)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: { _ in

        })
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }

    func sendMsg(textMsg: String) {
        lib.sendMessage(msg: textMsg, type: .msgText, consultId: consultId)
        if let cMsg = lib.sendingMsg {
//                print(WTimeConvertUtil.displayLocalTime(from: Double(cMsg.msgTime.seconds)))
//                print(WTimeConvertUtil.displayLocalTime(from: cMsg.msgTime.date))
            appendDataSource(msg: cMsg, isLeft: false, payLoadId: lib.payloadId)
        }
    }

    func sendImage(url: String) {
        // lib.sendMessageImage(url: "https://www.bing.com/th?id=OHR.SunriseCastle_ROW9509100997_1920x1080.jpg&rf=LaDigue_1920x1080.jpg")
        lib.sendMessage(msg: url, type: .msgImg, consultId: consultId)
        if let cMsg = lib.sendingMsg {
//                print(WTimeConvertUtil.displayLocalTime(from: Double(cMsg.msgTime.seconds)))
//                print(WTimeConvertUtil.displayLocalTime(from: cMsg.msgTime.date))
            appendDataSource(msg: cMsg, isLeft: false, payLoadId: lib.payloadId)
        }
    }

    func toolBar(toolBar: BWKeFuChatToolBar, menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {
        print(model.displayName)
    }

    func toolBar(toolBar: BWKeFuChatToolBar, didBeginEditing textView: UITextView) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didChanged textView: UITextView) {}

    func toolBar(toolBar: BWKeFuChatToolBar, didEndEditing textView: UITextView) {}

    /// 发送文字
    func toolBar(toolBar: BWKeFuChatToolBar, sendText context: String) {
        sendMsg(textMsg: context)
        self.toolBar.resetStatus()
    }

    @objc func toolBar(toolBar: BWKeFuChatToolBar, delete text: String, range: NSRange) -> Bool {
        return true
    }

    @objc func toolBar(toolBar: BWKeFuChatToolBar, changed text: String, range: NSRange) -> Bool {
        return true
    }

    func upload(imgData: Data) {
        // Set Your URL
        let api_url = baseUrlApi + "/v1/assets/upload/"
        guard let url = URL(string: api_url) else {
            return
        }

        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 10.0 * 1000)
        urlRequest.httpMethod = "POST"
        // urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        let boundary = "Boundary-\(UUID().uuidString)"
        let contentType = "multipart/form-data; " + boundary

        urlRequest.addValue(contentType, forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("multipart/form-data", forHTTPHeaderField: "Accept")
        urlRequest.httpBody = imgData

        urlRequest.addValue(xToken, forHTTPHeaderField: "X-Token")

        // Set Your Parameter
        let parameterDict = NSMutableDictionary()
        parameterDict.setValue(1, forKey: "type")
        // parameterDict.setValue("phot.png", forKey: "myFile")

        // Now Execute
        AF.upload(multipartFormData: { multiPart in
            for (key, value) in parameterDict {
                if let temp = value as? String {
                    multiPart.append(temp.data(using: .utf8)!, withName: key as! String)
                }
                if let temp = value as? Int {
                    multiPart.append("\(temp)".data(using: .utf8)!, withName: key as! String)
                }
            }
            multiPart.append(imgData, withName: "myFile", fileName: "file.png", mimeType: "image/png")
        }, with: urlRequest)
            .uploadProgress(queue: .main, closure: { progress in
                // Current upload progress of file
                print("Upload Progress: \(progress.fractionCompleted)")
            })
            .response(completionHandler: { data in
                switch data.result {
                case .success:

                    if let filePath = data.data {
                        let path = String(data: filePath, encoding: String.Encoding.utf8)
                        //let imgUrl = baseUrlImage + (path ?? "")
                        let imgUrl = (path ?? "")
                        print(imgUrl)
                        self.sendImage(url: imgUrl)
                    } else {
                        print("图片上传失败：")
                    }

                case .failure(let error):
                    print("图片上传失败：" + error.localizedDescription)
                }
            })
    }
}

extension KeFuViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func presentNoauth(isPhoto: Bool) {
        let vc = WWNoAuthorizeVC()
        vc.modalPresentationStyle = .fullScreen
        vc.isPhoto = isPhoto
        present(vc, animated: false)
    }

    func presentImagePicker(controller: UIImagePickerController, source: UIImagePickerController.SourceType) {
        controller.delegate = self
        controller.sourceType = source
        controller.allowsEditing = false
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true)
    }

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {
            return imagePickerControllerDidCancel(picker)
        }
        chooseImg = image
        guard let imgData = chooseImg?.jpegData(compressionQuality: 0.5) else { return }
        let tt = imgData.count
        print("图片大小：\(tt)")
        if tt > 2048000 {
            print("图片不能超过2M")
            let alertVC = UIAlertController(title: "提示", message: "图片不能超过2M", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "取消", style: .default, handler: { _ in
                picker.dismiss(animated: true)
            })
            alertVC.addAction(cancelAction)
            picker.present(alertVC, animated: true, completion: nil)
            return
        }
        upload(imgData: imgData)
        picker.dismiss(animated: false) {}
    }

    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true) {}
    }

    // 用户是否开启权限
    func authorize(authorizeClouse: @escaping (PHAuthorizationStatus) -> ()) {
        let status = PHPhotoLibrary.authorizationStatus()
        if status == .authorized {
            authorizeClouse(status)
        } else if status == .notDetermined { // 未授权，请求授权
            PHPhotoLibrary.requestAuthorization { state in
                DispatchQueue.main.async {
                    authorizeClouse(state)
                }
            }
        } else {
            authorizeClouse(status)
        }
    }

    // 用户是否开启相机权限
    func authorizeCamaro(authorizeClouse: @escaping (AVAuthorizationStatus) -> ()) {
        let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

        if status == .authorized {
            authorizeClouse(status)
        } else if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { granted in
                if granted { // 允许
                    authorizeClouse(.authorized)
                }
            })
        } else {
            authorizeClouse(status)
        }
    }

    func getStrFromImage() -> String {
        let imageOrigin = chooseImg
        if let image = imageOrigin {
            let dataTmp = image.jpegData(compressionQuality: 0.1)
            if let data = dataTmp {
                let imageStrTT = data.base64EncodedString()
                return imageStrTT
            }
        }
        return ""
    }
}

// MARK: - ----------------监听键盘高度变化

extension KeFuViewController {
    @objc func keyboardWillChangeFrame(node: Notification) {
        // 1.获取动画执行的时间
        let duration = node.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval

        // 2.获取键盘最终 Y值
        let endFrame = (node.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        let y = endFrame.origin.y

        // 3计算工具栏距离底部的间距
        let margin = UIScreen.main.bounds.height - y

        // 4.执行动画
        UIView.animate(withDuration: duration) { [weak self] in
            self?.toolBar.snp.updateConstraints { make in
                if margin == 0 {
                    make.bottom.equalToSuperview().offset(-kDeviceBottom)
                } else {
                    make.bottom.equalToSuperview().offset(-margin)
                }
            }
            self?.view.layoutIfNeeded()
        }
    }
}
