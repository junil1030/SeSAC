//
//  OtherMessageTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class OtherMessageTableViewCell: UITableViewCell {
    
    static let identifier = "OtherMessageTableViewCell"
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var bubbleView: UIView!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        messageLabel.numberOfLines = 0
        
        selectionStyle = .none
        
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .lightGray
        
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.borderColor = UIColor.black.cgColor
        bubbleView.layer.backgroundColor = UIColor.clear.cgColor
        bubbleView.layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil
        nameLabel.text = nil
        messageLabel.text = nil
    }
}
