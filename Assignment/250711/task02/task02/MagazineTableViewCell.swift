//
//  MagazineTableViewCell.swift
//  task02
//
//  Created by 서준일 on 7/12/25.
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
        photoImageView.layer.cornerRadius = 15
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
        dateLabel.text = formatDate(from: magazine.date)
        
        if let url = URL(string: magazine.photo_image) {
            photoImageView.kf.setImage(with: url)
        } else {
            photoImageView.image = UIImage(systemName: "airplane")
        }
    }
    
    private func formatDate(from dateString: String) -> String {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyMMdd"

        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yy년 MM월 dd일"

        if let date = inputFormatter.date(from: dateString) {
            return outputFormatter.string(from: date)
        } else {
            return dateString
        }
    }
}
