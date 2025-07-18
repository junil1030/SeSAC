//
//  ProfileTableViewCell.swift
//  SeSAC7Step1Remind
//
//  Created by 서준일 on 7/18/25.
//

import UIKit
import Kingfisher

class ProfileTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureView()
    }

    private func configureView() {
        profileImageView.backgroundColor = .blue
        profileImageView.contentMode = .scaleAspectFill
        
        nameLabel.font = .boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        desLabel.textColor = .black
    }
    
    func configureData(with row: Friends) {
        nameLabel.text = row.introduce
        desLabel.text = row.message
        
        if let imageURL = row.makeURL {
            profileImageView.kf.setImage(with: imageURL)
        } else {
            profileImageView.image = UIImage(systemName: "star.fill")
        }
    }
}
