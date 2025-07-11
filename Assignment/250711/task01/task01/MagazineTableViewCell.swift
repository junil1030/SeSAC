//
//  TravelTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/11/25.
//

import UIKit
import Kingfisher

class MagazineTableViewCell: UITableViewCell {
    
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
     
    override func awakeFromNib() {
        super.awakeFromNib()
        
        photoImageView.contentMode = .scaleAspectFill
        photoImageView.clipsToBounds = true
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        photoImageView.image = nil
        titleLabel.text = nil
        subTitleLabel.text = nil
        dateLabel.text = nil
    }
    
    func configure(with magazine: Magazine) {
        titleLabel.text = magazine.title
        subTitleLabel.text = magazine.subtitle
        dateLabel.text = magazine.date
        
        if let url = URL(string: magazine.photo_image) {
            photoImageView.kf.setImage(with: url)
        } else {
            photoImageView.image = UIImage(systemName: "airplane")
        }
        
    }
    
}
