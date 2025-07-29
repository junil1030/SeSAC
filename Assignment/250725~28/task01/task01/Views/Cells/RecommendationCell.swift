//
//  RecommendationCell.swift
//  task01
//
//  Created by 서준일 on 7/29/25.
//

import UIKit
import SnapKit
import Kingfisher

class RecommendationCell: UICollectionViewCell {
    static let identifier = "RecommendationCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 14)
        label.textColor = .white
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        imageView.image = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
    
    func configureData(with item: ShoppingItem) {
        let url = URL(string: item.image)
        imageView.kf.setImage(with: url)
        titleLabel.text = item.title.cleanText
        priceLabel.text = item.lprice.wonString
    }
}

extension RecommendationCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
            make.height.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(2)
            make.height.lessThanOrEqualTo(32)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(2)
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
    }
}
