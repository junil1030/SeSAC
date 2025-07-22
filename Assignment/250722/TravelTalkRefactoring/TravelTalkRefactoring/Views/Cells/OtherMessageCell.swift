//
//  OtherMessageCell.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class OtherMessageCell: UITableViewCell {

    static let identifier = "OtherMessageTableViewCell"
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .black
        return label
    }()
    
    private let bubbleView: UIView = {
        let bubbleView = UIView()
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.borderColor = UIColor.black.cgColor
        bubbleView.layer.backgroundColor = UIColor.clear.cgColor
        bubbleView.layer.cornerRadius = 12
        return bubbleView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.textAlignment = .left
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = contentView.frame.height * 0.15
        profileImageView.layer.cornerRadius = imageSize / 2
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        messageLabel.text = nil
        timeLabel.text = nil
    }

    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(nameLabel)
        contentView.addSubview(bubbleView)
        contentView.addSubview(timeLabel)
        bubbleView.addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.leading.equalTo(contentView).inset(8)
            make.width.height.equalTo(contentView.snp.width).multipliedBy(0.15)
        }

        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.top.equalTo(profileImageView.snp.top)
            make.height.equalTo(contentView.snp.height).multipliedBy(0.2)
        }

        bubbleView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(-2)
            make.leading.equalTo(profileImageView.snp.trailing).offset(4)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
            make.width.lessThanOrEqualTo(contentView.snp.width).multipliedBy(0.6).priority(.high)
        }

        messageLabel.snp.makeConstraints { make in
            make.edges.equalTo(bubbleView).inset(8)
        }

        timeLabel.snp.makeConstraints { make in
            make.leading.equalTo(bubbleView.snp.trailing).offset(4).priority(.medium)
            make.bottom.equalTo(bubbleView.snp.bottom)
            make.trailing.lessThanOrEqualTo(contentView).offset(-8).priority(.high)
            make.width.lessThanOrEqualTo(85)
        }
    }
    
    func configure(with chat: Chat) {
        profileImageView.image = UIImage(named: chat.user.image)
        nameLabel.text = chat.user.name
        messageLabel.text = chat.message
        timeLabel.text = chat.date.dateFormatted(to: .hmma)
    }
}
