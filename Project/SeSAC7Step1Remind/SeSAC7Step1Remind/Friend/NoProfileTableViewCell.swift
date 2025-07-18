//
//  NoProfileTableViewCell.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

class NoProfileTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    @IBOutlet var phoneLabel: UILabel!
    @IBOutlet var likeButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    // 달라지지 않을 디자인
    private func configureView() {
        backgroundColor = .clear
        likeButton.layer.cornerRadius = 22
        likeButton.clipsToBounds = true
        nameLabel.textColor = .white
        phoneLabel.textColor = .white
        messageLabel.textColor = .white
    }
    
    // 셀마다 데이터에 의해 달라질 데이터
    func configureData(with row: Friends) {
        nameLabel.text = row.name
        messageLabel.text = row.message
        
//        if row.message != nil {
//            messageLabel.isHidden = false
//        } else {
//            messageLabel.isHidden = true
//        }
        
        // isThatTrue? yes : no
        messageLabel.isHidden = row.message == nil ? true : false
        
        
//        if row.phone != nil {
//            phoneLabel.text = "\(row.phone!)"
//        } else {
//            phoneLabel.text = "연락처 없음"
//        }
        
        phoneLabel.text = row.phone == nil ? "연락처 없음" : "\(row.phone!)"
        
//        if row.like {
//            let image = UIImage(systemName: "heart.fill")
//            likeButton.setImage(image, for: .normal)
//        } else {
//            let image = UIImage(systemName: "heart")
//            likeButton.setImage(image, for: .normal)
//        }
        
        let image = row.like ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        likeButton.setImage(image, for: .normal)
    }
}
