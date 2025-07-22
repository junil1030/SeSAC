//
//  MyMessageCell.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class MyMessageCell: UITableViewCell {
    
    static let identifier = "MyMessageCell"
    
    private let bubbleView: UIView = {
        let bubbleView = UIView()
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.borderColor = UIColor.black.cgColor
        bubbleView.layer.backgroundColor = UIColor.customGrayColor.cgColor
        bubbleView.layer.cornerRadius = 12
        return bubbleView
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        return label
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        messageLabel.text = nil
        timeLabel.text = nil
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bubbleView)
        contentView.addSubview(timeLabel)
        bubbleView.addSubview(messageLabel)
    }
    
    private func setupConstraints() {
        bubbleView.snp.makeConstraints { make in
            make.trailing.top.bottom.equalTo(contentView).inset(8)
            make.width.lessThanOrEqualTo(280)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(85)
            make.trailing.equalTo(bubbleView.snp.leading).offset(-4)
            make.bottom.equalTo(bubbleView.snp.bottom)
        }
        
        messageLabel.snp.makeConstraints { make in
            make.edges.equalTo(bubbleView).inset(8)
        }
    }
    
    func configure(with chat: Chat) {
        messageLabel.text = chat.message
        timeLabel.text = chat.date.dateFormatted(to: .hmma)
    }

}
