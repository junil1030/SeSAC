//
//  CityInfoCollectionViewCell.swift
//  task01
//
//  Created by 서준일 on 7/19/25.
//

import UIKit

class CityInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityInfoCollectionViewCell"

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityExplainLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configure()
    }
    
    override func prepareForReuse() {
        cityImageView.image = nil
        cityNameLabel.text = nil
        cityExplainLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        cityImageView.layer.cornerRadius = cityImageView.frame.height / 2
    }
    
    private func configure() {
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
        
        cityNameLabel.font = .boldSystemFont(ofSize: 18)
        cityNameLabel.textAlignment = .center
        
        cityExplainLabel.font = .systemFont(ofSize: 15)
        cityExplainLabel.textColor = .gray
        cityExplainLabel.textAlignment = .center
    }

    func configureData(with row: City) {
        cityImageView.setImage(with: row.city_image)
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        cityExplainLabel.text = row.city_explain
    }
}
