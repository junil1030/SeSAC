//
//  UpDownGameCollectionViewCell.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class UpDownGameCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "UpDownGameCollectionViewCell"
    
    @IBOutlet var backView: UIView!
    @IBOutlet var numberLabel: UILabel!
    
    override var isSelected: Bool {
        didSet {
            backView.backgroundColor = isSelected ? .black : .white
            numberLabel.textColor = isSelected ? .white : .black
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        numberLabel.textAlignment = .center
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        backView.layer.cornerRadius = backView.frame.height / 2
        backView.clipsToBounds = true
    }
    
    func configureData(number: Int) {
        numberLabel.text = "\(number)"
    }
    
    func select() {
        backView.backgroundColor = .black
        numberLabel.textColor = .white
    }
}
