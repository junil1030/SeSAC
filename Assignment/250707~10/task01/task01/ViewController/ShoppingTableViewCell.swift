//
//  ShoppingTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class ShoppingTableViewCell: UITableViewCell {
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var productLabel: UILabel!
    @IBOutlet var favoriteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 248/255, alpha: 1)
        
        selectionStyle = .none
    }
}
