//
//  ChatViewController.swift
//  TeneasyChatSDK_iOS
//
//  Created by XiaoFu on 01/19/2023.
//  Copyright (c) 2023 XiaoFu. All rights reserved.
//

import PhotosUI
import TeneasyChatSDK_iOS
// import TeneasyChatSDKUI_iOS
import UIKit

open class ChatViewController: UIViewController, teneasySDKDelegate {
    lazy var imagePickerController: UIImagePickerController = {
        let pick = UIImagePickerController()
        pick.delegate = self
        return pick
    }()

    var chooseImg: UIImage?

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
        view.rowHeight = UITableView.automaticDimension
        return view
    }()

    var datasouceArray: [ChatModel] = []

    var lib = chatLib()

    override open func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = kBgColor

        initSDK()
        initView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChangeFrame(node:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
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
        lib = chatLib(chatId: 2692944494602,
                      token: "CCcQARgKIBwotaa8vuAw.TM241ffJsCLGVTPSv-G65MuEKXuOcPqUKzpVtiDoAnOCORwC0AbAQoATJ1z_tZaWDil9iz2dE4q5TyIwNcIVCQ")
        lib.callWebsocket()
        lib.delegate = self
    }

    public func receivedMsg(msg: TeneasyChatSDK_iOS.CommonMessage) {
        print("receivedMsg")
        appendDataSource(msg: msg, isLeft: true)
    }

    public func msgReceipt(msg: CommonMessage) {
        print("msgReceipt" + WTimeConvertUtil.displayLocalTime(from: msg.msgTime.date))
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
                    self?.presentNoauth(isPhoto: false)
                } else {
                    self?.presentImagePicker(controller: self?.imagePickerController ?? UIImagePickerController(), source: .camera)
                }
            }
        })
        alertVC.addAction(alertAction2)
        let cancelAction = UIAlertAction(title: "取消", style: .default, handler: { _ in

        })
        alertVC.addAction(cancelAction)
        present(alertVC, animated: true, completion: nil)
    }

    func sendMsg(context: String) {
        lib.sendMessage(msg: context)
    }

    func sendImage(context: String) {
        lib.sendMessageImage(url: "https://www.bing.com/th?id=OHR.SunriseCastle_ROW9509100997_1920x1080.jpg&rf=LaDigue_1920x1080.jpg")
    }

    func toolBar(toolBar: BWKeFuChatToolBar, menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {
        print(model.displayName)
    }

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

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
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

    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
   
        guard let image = info[UIImagePickerController.InfoKey.originalImage.rawValue] as? UIImage else {
            return imagePickerControllerDidCancel(picker)
        }
        chooseImg = image
        self.upload()

        picker.dismiss(animated: false) {
//            let vc = WWResizerController()
//            vc.img = image
//            vc.modalPresentationStyle = .fullScreen
//            vc.doneClock = { [weak self] img in
//                self?.chooseImg = img
//                self?.headView.imageView.image = img
//                self?.upload()
//            }
//            self.present(vc, animated: true)
        }
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

    func upload() {
        print(getStrFromImage())
//        NetRequest.standard.enqueuePOSTRequest(urlStr: "https://csapi.xdev.stream/v1/assets/upload", params: <#T##[String : Any]?#>)
//        WWProgressHUD.showLoading()
//        var req = ApiAssetUploadAvatarRequest(data: getStrFromImage())
//        ApiAssetAsset.UploadAvatar(req: &req) { [weak self] code, rep in
//            WWProgressHUD.dismiss()
//            if WApiControUtil.controll(code, rep) {
//                let assetId = rep?.data?.assetId
//                guard let id = assetId else { return }
        ////                let assetUrl = IFinal.assetUrl + String(id)
//                self?.settingAvator(id: id)
//            }
//        }
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

extension ChatViewController {
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
