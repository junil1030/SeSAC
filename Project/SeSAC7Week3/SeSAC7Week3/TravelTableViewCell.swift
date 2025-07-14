//
//  TravelTableViewCell.swift
//  SeSAC7Week3
//
//  Created by 서준일 on 7/14/25.
//

import UIKit

class TravelTableViewCell: UITableViewCell {
    
    @IBOutlet var dateLabel: UILabel!
    @IBOutlet var travelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        travelLabel.backgroundColor = .systemYellow
        travelLabel.text = "텍스트"
        travelLabel.font = .boldSystemFont(ofSize: 17)
        travelLabel.numberOfLines = 0
        travelLabel.backgroundColor = .clear
        
        dateLabel.backgroundColor = .clear
    }
    
    override func prepareForReuse() {
        dateLabel.text = nil
        travelLabel.text = nil
        backgroundColor = .clear
    }
    
    func configure(with travel: Travel) {
        configureDateLabel(name: travel.name)
        configureTravelLabel(overview: travel.overview)
        configureBackground(isLiked: travel.like)
    }
    
    private func configureDateLabel(name: String) {
        dateLabel.text = name

    }
    
    private func configureTravelLabel(overview: String) {
        travelLabel.text = overview
    }
    
    private func configureBackground(isLiked: Bool) {
        if isLiked {
            backgroundColor = .yellow
        } else {
            backgroundColor = .clear
        }
    }
}
