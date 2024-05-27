//
//  BWVideoCell.swift
//  TeneasyChatSDKUI_iOS
//
//  Created by Xiao Fu on 2024/5/27.
//


import AVFoundation
import Kingfisher
import UIKit

class BWVideoCell: UITableViewCell {
    
    lazy var timeLab: UILabel = {
        let lab = UILabel()
        lab.font = UIFont.systemFont(ofSize: 13)
        lab.textColor = .black
        lab.lineBreakMode = .byTruncatingTail
        return lab
    }()

    lazy var videoBackgroundView: UIView = {
        let blackBackgroundView = UIView()
        return blackBackgroundView
    }()

    lazy var playBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle("play", for: UIControl.State.normal)
        btn.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
        return btn
    }()
    
    private var player: AVPlayer?
    private var playerLayer: AVPlayerLayer?
    
    static func cell(tableView: UITableView) -> Self {
        let cellId = "\(Self.self)"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellId)
        if cell == nil {
            cell = Self(style: .default, reuseIdentifier: cellId)
        }
        
        return cell as! Self
    }
    
    @objc private func playButtonTapped() {
        self.playBtn.isHidden = true
        self.player?.play()
    }
    
    override required init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .clear
                
        self.contentView.addSubview(self.timeLab)
        self.contentView.addSubview(self.titleLab)
        self.contentView.addSubview(self.imgView)
        self.imgView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(12)
            make.width.equalTo(kScreenWidth - 12 - 80)
            make.top.equalTo(self.timeLab.snp.bottom)
            make.height.equalTo(0)
        }
        self.gesture = UILongPressGestureRecognizer(target: self, action: #selector(self.longGestureClick(tap:)))
        self.contentView.addGestureRecognizer(self.gesture!)
        
        self.contentView.addSubview(self.playBtn)
        self.playBtn.isHidden = true
        self.playBtn.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        self.setupPlayerLayer()
    }

    @objc func longGestureClick(tap: UILongPressGestureRecognizer) {
        self.longGestCallBack?(tap)
    }
    
    var model: ChatModel? {
        didSet {
            guard let msg = model?.message else {
                return
            }
            // 现在SDK并没有把时间传回来，所以暂时不用这样转换
         
            self.timeLab.text = WTimeConvertUtil.displayLocalTime(from: msg.msgTime.date)
       
            if msg.image.uri.isEmpty == false {
                let imgUrl = URL(string: "\(baseUrlImage)\(msg.image.uri)")
                print(imgUrl?.absoluteString ?? "")
                if imgUrl != nil {
                    self.initImg(imgUrl: imgUrl!)
                } else {
                    self.initTitle()
                }
            } else if msg.video.uri.isEmpty == false {
                let videoUrl = URL(string: "\(baseUrlImage)\(msg.video.uri)")
                print(videoUrl?.absoluteString ?? "")
                if videoUrl != nil {
                    self.initVideo(videoUrl: videoUrl!)
                } else {
                    self.initTitle()
                }
            } else {
                self.initTitle()
            }
            if msg.content.data.contains("[emoticon_") == true {
                let atttext = BEmotionHelper.shared.attributedStringByText(text: msg.content.data, font: self.titleLab.font)
                self.titleLab.attributedText = atttext
            } else {
                self.titleLab.text = msg.content.data
                // print("message text:" + (msg.content.data))
            }
        }
    }
    
    private func setupPlayerLayer() {
        playerLayer = AVPlayerLayer()
        playerLayer?.videoGravity = .resizeAspect
        if let playerLayer = playerLayer {
            contentView.layer.addSublayer(playerLayer)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.playerLayer?.frame = contentView.bounds
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.player?.pause()
        self.playerLayer?.player = nil
    }
    
    func initImg(imgUrl: URL) {
        self.imgView.snp.updateConstraints { make in
            make.height.equalTo(160)
        }
        self.imgView.kf.setImage(with: imgUrl)
        self.titleLab.isHidden = true
        self.imgView.isHidden = false
        self.playerLayer?.isHidden = true
        self.player?.pause()
        self.playerLayer?.player = nil
        self.playBtn.isHidden = true
    }

    func initVideo(videoUrl: URL) {
        self.imgView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        self.titleLab.isHidden = true
        self.imgView.isHidden = true
        self.playerLayer?.isHidden = false
        self.player = AVPlayer(url: videoUrl)
        self.playerLayer?.player = self.player
        self.playBtn.isHidden = false
    }

    func initTitle() {
        self.imgView.snp.updateConstraints { make in
            make.height.equalTo(0)
        }
        self.titleLab.isHidden = false
        self.imgView.isHidden = true
        self.playerLayer?.isHidden = true
        self.player?.pause()
        self.playerLayer?.player = nil
        self.playBtn.isHidden = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    @objc func handleTapImg() {
        if let window = UIApplication.shared.keyWindow {
            window.addSubview(self.blackBackgroundView)
            self.blackBackgroundView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
                
            let imageView = UIImageView(image: self.imgView.image)
            imageView.contentMode = .scaleAspectFit
            imageView.isUserInteractionEnabled = true
            window.addSubview(imageView)
            imageView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
                
            UIView.animate(withDuration: 0.75, animations: {
                self.blackBackgroundView.alpha = 1
                
            })
                
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissFullscreenImage))
            imageView.addGestureRecognizer(tapGesture)
        }
    }
        
    @objc func dismissFullscreenImage(_ sender: UITapGestureRecognizer) {
        UIView.animate(withDuration: 0.35, animations: {
            self.blackBackgroundView.alpha = 0
            sender.view?.alpha = 0
        }, completion: { _ in
            sender.view?.removeFromSuperview()
            self.blackBackgroundView.removeFromSuperview()
        })
    }
}import Foundation
