//
//  ChatCollectionViewCell.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class ChatCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "ChatCollectionViewCell"

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var profileNameLabel: UILabel!
    @IBOutlet var currentMessageLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
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
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
    }
    
    private func configure() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        profileNameLabel.font = .boldSystemFont(ofSize: 18)
        profileNameLabel.textAlignment = .left
        
        currentMessageLabel.font = .systemFont(ofSize: 15)
        currentMessageLabel.textColor = .gray
        currentMessageLabel.textAlignment = .left
        
        dateLabel.font = .systemFont(ofSize: 15)
        dateLabel.textColor = .gray
        dateLabel.textAlignment = .right
    }
    
    func configureData(with chat: ChatRoom) {
        profileImageView.image = UIImage(named: chat.chatroomImage)
        profileNameLabel.text = chat.chatroomName
        currentMessageLabel.text = chat.chatList.last?.message
        dateLabel.text = chat.chatList.last?.date.dateFormatted(to: .yyMMdd)
    }

}
