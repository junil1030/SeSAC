//
//  MyMessageCell.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class ChatCell: UICollectionViewCell {
    static let identifier = "ChatCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let profileNameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private let currentMessageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .gray
        label.textAlignment = .right
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(profileNameLabel)
        contentView.addSubview(currentMessageLabel)
        contentView.addSubview(dateLabel)
        
        contentView.backgroundColor = .clear
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        profileNameLabel.text = nil
        currentMessageLabel.text = nil
        dateLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateCornerRadius()
    }
    
    private func setupUI() {
        profileImageView.snp.makeConstraints { make in
            make.verticalEdges.left.equalToSuperview().inset(4)
            make.width.equalTo(profileImageView.snp.height)
        }
        
        profileNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-13)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        currentMessageLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(13)
            make.left.equalTo(profileImageView.snp.right).offset(8)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(8)
            make.centerY.equalTo(profileNameLabel)
        }
    }
    
    private func updateCornerRadius() {
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    func configureData(with chat: ChatRoom) {
        profileImageView.image = UIImage(named: chat.chatroomImage)
        profileNameLabel.text = chat.chatroomName
        currentMessageLabel.text = chat.chatList.last?.message
        dateLabel.text = chat.chatList.last?.date
        
        layoutIfNeeded()
        updateCornerRadius()
    }
}
