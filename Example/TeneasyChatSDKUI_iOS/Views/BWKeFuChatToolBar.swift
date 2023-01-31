//
//  BWKeFuChatToolView.swift
//  ProgramIOS
//
//  Created by 韩寒 on 2021/8/19.
//  输入框工具栏

import UIKit
import IQKeyboardManagerSwift
//插入的图片附件的尺寸样式
enum  ImageAttachmentMode  {
    case  Default   //默认（不改变大小）
    case  FitTextLine   //使尺寸适应行高
    case  FitTextView   //使尺寸适应textView
}

protocol BWKeFuChatToolBarDelegate: AnyObject {
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedVoice btn:UIButton)
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedMenu btn:UIButton)
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedPhoto btn:UIButton)
    func toolBar(toolBar: BWKeFuChatToolBar, didSelectedEmoji btn:UIButton)
    func toolBar(toolBar: BWKeFuChatToolBar, sendVoice gesture:UILongPressGestureRecognizer)
    func toolBar(toolBar: BWKeFuChatToolBar, menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion)
    func toolBar(toolBar: BWKeFuChatToolBar, didBeginEditing textView: UITextView)
    func toolBar(toolBar: BWKeFuChatToolBar, didChanged textView: UITextView)
    func toolBar(toolBar: BWKeFuChatToolBar, didEndEditing textView: UITextView)
    func toolBar(toolBar: BWKeFuChatToolBar, sendText context: String)
    func toolBar(toolBar: BWKeFuChatToolBar, changed text: String, range: NSRange) -> Bool
    func toolBar(toolBar: BWKeFuChatToolBar, delete text: String, range: NSRange) -> Bool
}

class BWKeFuChatToolBar: UIView {
    
    public weak var delegate: BWKeFuChatToolBarDelegate?
    private var isShowMenuView = true
    
    private var inputMinHeight:CGFloat = 33;
    private var inputMaxHeight:CGFloat = 90;
    
    //保存的输入字符串，当多行文本时，切换语音/键盘按钮，会出现toolBar高度不适应的问题（contentSize）
    var savedText:NSAttributedString = NSAttributedString(string:"")
    
    
    ///监听是否输入
//    var viewMode:ChatP2PVM?
    ///监听次数
    var editCount:Int16 = 0
    lazy var voiceBtn: WButton = {
        let btn = WButton()
//        btn.setImage(UIImage.svgInit("lt_yuying.svg"), for: .normal)
//        btn.setImage(UIImage.svgInit("lt_jianpan.svg"), for: .selected)
        return btn;
    }()
    
    private  lazy var emojiBtn: WButton = {
        let btn = WButton()
        let image = UIImage(named: "lt_biaoqing")
        let selImage = UIImage(named: "lt_jianpan")
        btn.setImage(image?.withRenderingMode(.alwaysOriginal), for: .normal)
        btn.setImage(selImage, for: .selected)
        return btn;
    }()
    
    private lazy var menuBtn: WButton = {
        let btn = WButton()
        btn.setBackgroundImage(UIImage(named: "lt_gengduo"), for: .normal)
        btn.setBackgroundImage(UIImage(named: "icon_chat_toggle_send"), for: .selected)
        return btn;
    }()

    lazy  var placeTextField: UITextField = {
        let text = UITextField();
        text.delegate = self
        return text;
    }()
    
    private lazy var sendVoiceBtn: UIButton = {
        let btn = UIButton();
        btn.layer.cornerRadius = (5)
        btn.layer.masksToBounds = true
//        btn.titleLabel?.font = kFont(fontSize: (14), weight: .medium)
//        btn.backgroundColor = AppColor.global_bg_1
//        btn.setTitleColor(AppColor.global_textColor_1, for: .normal)
//        btn.setTitle("按住 说话", for: .normal)
//        btn.setTitle("松开 发送", for: .selected)
        return btn;
    }()
    
    lazy var textView: IQTextView = {
        let text = IQTextView.init();
        text.layer.cornerRadius = (5)
        text.layer.masksToBounds = true
        text.backgroundColor = .groupTableViewBackground
        text.delegate = self
        text.font = UIFont.systemFont(ofSize: 14)
        text.textColor = .groupTableViewBackground
        text.returnKeyType = .send
        text.isSelectable = true
        return text
    }()
    
    /// 菜单视图
    lazy var menuView: BWKeFuChatMenuView = {
        let menuView = BWKeFuChatMenuView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (240)))
        menuView.backgroundColor = .groupTableViewBackground
        menuView.delegate = self
        return menuView
    }()
    
    /// 表情视图
    lazy var emojiView: BWKeFuChatEmojiView = {
        let emojiView = BWKeFuChatEmojiView(frame: CGRect(x: 0, y: 0, width: kScreenWidth, height: (285)))
        emojiView.delegate = self
        emojiView.backgroundColor = .groupTableViewBackground
        return emojiView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame);

        initSubViews()
        initBindModel();
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func initSubViews() {
        /// 语音按钮
//        addSubview(voiceBtn)
//        voiceBtn.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset((10))
//            make.width.height.equalTo((23))
//            make.centerY.equalToSuperview();
//        }
 
        /// 菜单/发送按钮
        addSubview(menuBtn)
        menuBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.width.height.equalTo((23))
        }

        /// 表情按钮
        addSubview(emojiBtn)
        emojiBtn.snp.makeConstraints { make in
            make.right.equalTo(menuBtn.snp.left).offset(-10)
            make.centerY.equalTo(menuBtn)
            make.width.height.equalTo((23))
        }
        
        /// 占位输入框
        addSubview(placeTextField)
        placeTextField.snp.makeConstraints { make in
            make.left.equalToSuperview().offset((10))
            make.right.equalTo(emojiBtn.snp.left).offset(-10)
            make.centerY.equalToSuperview();
            make.height.equalTo((32))
        }
        
        /// 录制语音按钮
//        addSubview(sendVoiceBtn)
//        sendVoiceBtn.snp.makeConstraints { make in
//            make.left.equalTo(voiceBtn.snp.right).offset((10))
//            make.right.equalTo(emojiBtn.snp.left).offset(-10)
//            make.bottom.equalToSuperview().offset(-7)
//            make.height.equalTo(inputMinHeight)
//        }

        /// 输入框
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset((10))
            make.right.equalTo(emojiBtn.snp.left).offset(-10)
            make.top.equalToSuperview().offset((7))
            make.bottom.equalToSuperview().offset(-7)
            make.height.equalTo(inputMinHeight)
        }
    }
    
    func initBindModel()  {
        
        BEmotionHelper.shared.emotionArray = BEmotionHelper.getNewEmoji()
        backgroundColor = kBgColor
        textView.addObserver(self, forKeyPath: "attributedText", options: .new, context: nil)
        textView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil);
        
        voiceBtn.addTarget(self, action: #selector(voiceBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        menuBtn.addTarget(self, action: #selector(menuBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        emojiBtn.addTarget(self, action: #selector(emojiBtnAction(sender:)), for: UIControlEvents.touchUpInside)
        
        let sendVoiceGesture = UILongPressGestureRecognizer(target: self, action: #selector(sendVoiceGesture(sender:)))
        sendVoiceBtn.addGestureRecognizer(sendVoiceGesture)
        
        //轻点按钮手势
        let singleTapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped(sender:)))
        sendVoiceBtn.addGestureRecognizer(singleTapGesture)
        
        /// 主动调一下懒加载，提前创建好两个视图
        self.placeTextField.inputView = self.menuView
        self.placeTextField.inputView = self.emojiView
    }
    
    deinit {
        textView.removeObserver(self, forKeyPath: "attributedText", context: nil)
        textView.removeObserver(self, forKeyPath: "contentSize", context: nil)
    }
}

//MARK:---------------公有方法
extension BWKeFuChatToolBar {
    /// 重设状态
    public func resetStatus() {
        isShowMenuView = true
        emojiBtn.isSelected = false
        
        let attributedText = textView.attributedText
        if attributedText?.length ?? 0 > 0 {
            menuBtn.isSelected = true
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((55))
                make.height.equalTo((32))
            }
        } else {
            menuBtn.isSelected = false
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((23))
                make.height.equalTo((23))
            }
        }
        
        textView.resignFirstResponder()
        placeTextField.resignFirstResponder()
    }
    
    ///全体禁言
    func banChat(isBan:Bool){
        
    }
    
    ///将语音模式切换到文本输入模式
    public func setTextInputModel() {
        if voiceBtn.isSelected {
            voiceBtnAction(sender: voiceBtn)
        }
    }
    
}

//MARK:---------------私有方法
extension BWKeFuChatToolBar {
    /// 语音/文字切换
    @objc private func voiceBtnAction(sender: UIButton) {
        //使点击加号按钮，不会切换至输入模式
        isShowMenuView = true
        
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            savedText = textView.attributedText
            textView.isHidden = true
            sendVoiceBtn.isHidden = false
            textView.text = ""
            textView.resignFirstResponder()
            placeTextField.resignFirstResponder()
            placeTextField.inputView = nil
            
            menuBtn.isSelected = false
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((23))
                make.height.equalTo((23))
            }
            textView.snp.updateConstraints { make in
                make.height.equalTo(inputMinHeight);
            }
        } else {
            textView.isHidden = false
            sendVoiceBtn.isHidden = true
            textView.attributedText = savedText
//            textView.becomeFirstResponder()
            
            if textView.attributedText.length > 0 {
                menuBtn.isSelected = true
                menuBtn.snp.updateConstraints { make in
                    make.width.equalTo((55))
                    make.height.equalTo((32))
                }
            } else {
                menuBtn.isSelected = false
                menuBtn.snp.updateConstraints { make in
                    make.width.equalTo((23))
                    make.height.equalTo((23))
                }
            }
        }
        
        emojiBtn.isSelected = false
        delegate?.toolBar(toolBar: self, didSelectedVoice: sender)
    }
    
    /// 菜单
    @objc private func menuBtnAction(sender: UIButton) {
//        if sender.isSelected == true {      // 发送消息
//            self.delegate?.toolBar(toolBar: self, sendText: textView.normalText())
//            return;
//        } else {                            // 打开菜单
//
//            if isShowMenuView {
////                self.placeTextField.inputView = self.menuView
////                self.placeTextField.reloadInputViews()
////                self.placeTextField.becomeFirstResponder()
////                self.textView.resignFirstResponder()
//                UIView.animate(withDuration: 0.25) {[weak self] in
//                    self?.placeTextField.inputView = self?.menuView
//                    self?.placeTextField.becomeFirstResponder()
//                    self?.placeTextField.reloadInputViews()
//                    self?.textView.isHidden = false
//                }
//                isShowMenuView = !isShowMenuView
//
//            } else {
////                if self.placeTextField.inputView == self.menuView {
////                    return
////                }
//                UIView.animate(withDuration: 0.25) {[weak self] in
//                    self?.placeTextField.inputView = nil
//                    self?.textView.becomeFirstResponder()
//                    self?.textView.reloadInputViews()
//                }
//                isShowMenuView = !isShowMenuView
//            }
//            //toolBar调整为输入模式
//            textView.isHidden = false
//            emojiBtn.isSelected = false
//            voiceBtn.isSelected = false
//            menuBtn.isSelected = false
//            sendVoiceBtn.isHidden = true
//        }
        
        delegate?.toolBar(toolBar: self, didSelectedPhoto: sender)
        
    }
    
    /// 表情
    @objc private func emojiBtnAction(sender: UIButton) {
        sender.isSelected = !sender.isSelected
        if sender.isSelected {
            UIView.animate(withDuration: 0.25) {[weak self] in
                self?.placeTextField.inputView = self?.emojiView
                self?.placeTextField.becomeFirstResponder()
                self?.placeTextField.reloadInputViews()
                self?.textView.isHidden = false
                self?.sendVoiceBtn.isHidden = true
                self?.voiceBtn.isSelected = false
            }
        } else {
            UIView.animate(withDuration: 0.25) {[weak self] in
                self?.textView.isHidden = false
                self?.sendVoiceBtn.isHidden = true
                self?.placeTextField.inputView = nil
                self?.textView.becomeFirstResponder()
                self?.textView.reloadInputViews()
            }
        }
        
        sendVoiceBtn.isSelected = false
        isShowMenuView = true
        menuBtn.isSelected = true
        if textView.attributedText.length > 0 {
            menuBtn.isSelected = true
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((55))
                make.height.equalTo((32))
            }
        } else {
            menuBtn.isSelected = false
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((23))
                make.height.equalTo((23))
            }
        }
        
        delegate?.toolBar(toolBar: self, didSelectedEmoji: sender)
    }
    
    /// 录制语音
    @objc private func sendVoiceGesture(sender: UILongPressGestureRecognizer) {
        
        if sender.state == UIGestureRecognizer.State.began {
            NSLog("开始")
            sendVoiceBtn.isSelected = true
        } else if sender.state == UIGestureRecognizer.State.possible{
            NSLog("possible")
        } else if sender.state == UIGestureRecognizer.State.changed{
        
        } else if sender.state == UIGestureRecognizer.State.ended{
            NSLog("结束")
            sendVoiceBtn.isSelected = false
        } else if sender.state == UIGestureRecognizer.State.cancelled {
            NSLog("取消")
        } else {
            NSLog("失败")
        }
        
        delegate?.toolBar(toolBar: self, sendVoice: sender)
    }
    
    @objc private func tapped(sender: UIButton) {
        //makeToast("长按按钮！")
        //[CSToastManager defaultPosition]
//        makeToast("长按按钮！", duration: 1, position: CSToastManager.defaultPosition)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "attributedText" {
            let attributedText = change?[.newKey] as! NSAttributedString
            if attributedText.length > 0 {
                menuBtn.isSelected = true
                menuBtn.snp.updateConstraints { make in
                    make.width.equalTo((55))
                    make.height.equalTo((32))
                }
            } else {
                menuBtn.isSelected = false
                menuBtn.snp.updateConstraints { make in
                    make.width.equalTo((23))
                    make.height.equalTo((23))
                }
            }
        }else if keyPath == "contentSize" {
            guard let contentSize = change?[.newKey] as? CGSize else { return  }
            var height = contentSize.height
            if height > self.inputMaxHeight {
                height = self.inputMaxHeight;
            }else if height < self.inputMinHeight {
                height = self.inputMinHeight
            }
            
            self.textView.snp.updateConstraints { make in
                make.height.equalTo(height);
            }
            self.layoutIfNeeded();
        }
    }
    
  
}

extension BWKeFuChatToolBar: UITextViewDelegate,UITextFieldDelegate {

    func textViewDidBeginEditing(_ textView: UITextView) {
        emojiBtn.isSelected = false
        isShowMenuView = true
        //textview变成第一响应后，不一定是“正在输入中”
        delegate?.toolBar(toolBar: self, didBeginEditing: textView)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        //发送系统通知“正在输入中”
        delegate?.toolBar(toolBar: self, didChanged: textView)
        
        if textView.attributedText.length > 0 {
            menuBtn.isSelected = true
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((55))
                make.height.equalTo((32))
            }
            self.emojiView.setDeleteButtonState(enable: true)
        } else {
            menuBtn.isSelected = false
            menuBtn.snp.updateConstraints { make in
                make.width.equalTo((23))
                make.height.equalTo((23))
            }
            self.emojiView.setDeleteButtonState(enable: false)
        }
        savedText = textView.attributedText
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        //更改状态“正在输入中”
        delegate?.toolBar(toolBar: self, didEndEditing: textView)
    }
        
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            self.delegate?.toolBar(toolBar: self, sendText: textView.normalText())
            return false
        }
        if text.count == 0 {
            if let delegate = delegate {
              return delegate.toolBar(toolBar: self, delete: text, range: range)
            }
        } else {
            return delegate?.toolBar(toolBar: self, changed: text, range: range) ?? true
        }
        return true
    }
}

extension BWKeFuChatToolBar: BWKeFuChatEmojiViewDelegate {
    
    func emojiView(emojiView: BWKeFuChatEmojiView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {
        let faceManager = BEmotionHelper.shared;
        let emotionAttr = faceManager.obtainAttributedStringByImageKey(imageKey: model.displayName, font: self.textView.font ?? UIFont.systemFont(ofSize: 14), useCache: false);
        self.textView.insertEmotionAttributedString(emotionAttributedString: emotionAttr);
        self.textView.scrollRangeToVisible(NSRange(location: textView.text.count, length: 0))
    }
    
    
    func emojiView(emojiView: BWKeFuChatEmojiView, didSelectDelete btn: WButton) {
        if self.textView.attributedText.length == 0 {
            return
        }
        if !self.textView.deleteEmotion() {
            self.textView.deleteBackward();
        }
        if self.textView.attributedText.length == 0 {
            self.emojiView.setDeleteButtonState(enable: false)
        }
        else {
            self.emojiView.setDeleteButtonState(enable: true)
        }
    }
}

extension BWKeFuChatToolBar: BWKeFuChatMenuViewDelegate {
    func menuView(menuView: BWKeFuChatMenuView, collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath, model: BEmotion) {
        delegate?.toolBar(toolBar: self, menuView: menuView, collectionView: collectionView, didSelectItemAt: indexPath, model: model)
    }
}

