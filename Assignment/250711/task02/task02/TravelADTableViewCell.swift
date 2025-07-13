//
//  TravelADTableViewCell.swift
//  task02
//
//  Created by 서준일 on 7/13/25.
//

import UIKit

class TravelADTableViewCell: UITableViewCell {

    @IBOutlet var backGroundView: UIView!
    @IBOutlet var adContentLabel: UILabel!
    @IBOutlet var adLabel: UILabel!
    
    let pastelColors: [UIColor] = [
        UIColor(red: 255/255, green: 182/255, blue: 193/255, alpha: 1.0),
        UIColor(red: 173/255, green: 216/255, blue: 230/255, alpha: 1.0),
        UIColor(red: 221/255, green: 160/255, blue: 221/255, alpha: 1.0),
        UIColor(red: 144/255, green: 238/255, blue: 144/255, alpha: 1.0),
        UIColor(red: 255/255, green: 218/255, blue: 185/255, alpha: 1.0),
        UIColor(red: 255/255, green: 255/255, blue: 224/255, alpha: 1.0),
        UIColor(red: 230/255, green: 230/255, blue: 250/255, alpha: 1.0),
        UIColor(red: 240/255, green: 248/255, blue: 255/255, alpha: 1.0),
        UIColor(red: 250/255, green: 240/255, blue: 230/255, alpha: 1.0),
        UIColor(red: 255/255, green: 240/255, blue: 245/255, alpha: 1.0)
    ]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backGroundView.backgroundColor = pastelColors.randomElement() ?? UIColor.lightGray
        backGroundView.layer.cornerRadius =  15
        adLabel.layer.cornerRadius = 5
        adLabel.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        adContentLabel.text = nil
    }

    func configure(with travel: Travel) {
        adContentLabel.text = travel.title
    }
}
