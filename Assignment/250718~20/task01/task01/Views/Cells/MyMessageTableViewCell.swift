//
//  MyMessageTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class MyMessageTableViewCell: UITableViewCell {
    
    static let identifier = "MyMessageTableViewCell"

    @IBOutlet var bubbleView: UIView!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        messageLabel.numberOfLines = 0
        
        selectionStyle = .none
        
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .lightGray
        
        bubbleView.layer.borderWidth = 1
        bubbleView.layer.borderColor = UIColor.black.cgColor
        bubbleView.layer.backgroundColor = CustomColor.grayColor.cgColor
        bubbleView.layer.cornerRadius = 12
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        timeLabel.text = nil
        messageLabel.text = nil
    }
    
}
