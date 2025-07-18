//
//  CityInfoTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class CityInfoTableViewCell: UITableViewCell {
    
    static let identifier = "CityInfoTableViewCell"

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainBackgroundView: UIView!
    @IBOutlet var explainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    private func configure() {
        contentView.layer.cornerRadius = 20
        contentView.layer.maskedCorners = [
            .layerMinXMinYCorner,
            .layerMaxXMaxYCorner
        ]
        contentView.clipsToBounds = true
        
        explainBackgroundView.backgroundColor = .black.withAlphaComponent(0.5)
        
        cityNameLabel.textColor = .white
        cityNameLabel.font = .boldSystemFont(ofSize: 28)
        
        explainLabel.textColor = .white
        explainLabel.font = .systemFont(ofSize: 20)
        
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
    }
    
    func configureData(with row: City) {
        backgroundImageView.setImage(with: row.city_image)
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        explainLabel.text = row.city_explain
    }
}
