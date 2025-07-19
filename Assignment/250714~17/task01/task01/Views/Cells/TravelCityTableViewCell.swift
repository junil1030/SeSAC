//
//  TravelCityTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit
import Kingfisher

class TravelCityTableViewCell: UITableViewCell {
    
    static let identifier = "TravelCityTableViewCell"

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var reviewStarImageVIew: [UIImageView]!
    @IBOutlet var reviewLabel: UILabel!
    @IBOutlet var saveLabel: UILabel!
    @IBOutlet var travelImage: UIImageView!
    @IBOutlet var likeButton: UIButton!
    
    private var isLiked: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        updateLikeButtonAppearance()
        travelImage.contentMode = .scaleAspectFill
        travelImage.layer.cornerRadius = 8
        travelImage.clipsToBounds = true
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        subTitleLabel.text = nil
        reviewLabel.text = nil
        saveLabel.text = nil
        travelImage.image = nil
    }
    
    func configure(with travel: Travel) {
        titleLabel.text = travel.title
        subTitleLabel.text = travel.description
        setRatingImage(travel.grade)
        
        if let imageUrlString = travel.travel_image {
            if let imageURL = URL(string: imageUrlString) {
                travelImage.kf.setImage(with: imageURL)
            }
        }
        
        if let isLiked = travel.like {
            self.isLiked = isLiked
        }
        updateLikeButtonAppearance()
        
        if let review = travel.review {
            reviewLabel.text = "(\(review.formattedWithComma))"
        }
        
        if let save = travel.save {
            saveLabel.text = "저장 \(save.formattedWithComma)"
        }
        
    }
    
    private func setRatingImage(_ rating: Double?) {
        guard let reviewRate = rating else {
            for imageView in reviewStarImageVIew {
                imageView.tintColor = .systemGray
            }
            return
        }
        
        let yellowStar = Int(reviewRate)
        
        for (index, imageView) in reviewStarImageVIew.enumerated() {
            if index < yellowStar {
                imageView.tintColor = .systemYellow
            } else {
                imageView.tintColor = .systemGray
            }
        }
    }
    
    private func updateLikeButtonAppearance() {
        if isLiked {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        isLiked.toggle()
    }
}
