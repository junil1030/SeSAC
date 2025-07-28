//
//  ProductCell.swift
//  task01
//
//  Created by 서준일 on 7/26/25.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCell: UICollectionViewCell {
    static let identifier = "ProductCell"
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = nil
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 8
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mallNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = .lightGray
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .gray
        label.numberOfLines = 2
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .white
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 16
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 1)
        button.layer.shadowOpacity = 0.1
        button.layer.shadowRadius = 2
        return button
    }()
    
    private var isLiked: Bool = false {
        didSet {
            updateLikeButton()
        }
    }
    
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
        mallNameLabel.text = nil
        titleLabel.text = nil
        priceLabel.text = nil
    }
    
    func configureData(with item: ShoppingItem) {
        let url = URL(string: item.image)
        imageView.kf.setImage(with: url)
        mallNameLabel.text = item.mallName
        titleLabel.text = item.title.cleanText
        priceLabel.text = item.lprice.wonString
    }
    
    @objc private func likeButtonTapped() {
        isLiked.toggle()
    }
    
    private func updateLikeButton() {
        let heartImage: UIImage?
        
        if isLiked {
            heartImage = UIImage(systemName: "heart.fill")
        } else {
            heartImage = UIImage(systemName: "heart")
        }
        
        likeButton.setImage(heartImage, for: .normal)
        likeButton.tintColor = .black
    }
}

extension ProductCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(imageView)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {
        imageView.snp.makeConstraints { make in
            make.horizontalEdges.top.equalToSuperview()
            make.height.equalTo(imageView.snp.width)
        }
        
        mallNameLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mallNameLabel.snp.bottom).offset(2)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.lessThanOrEqualTo(52)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.horizontalEdges.equalToSuperview().inset(8)
            make.height.lessThanOrEqualTo(36)
        }
        
        likeButton.snp.makeConstraints { make in
            make.trailing.equalTo(imageView.snp.trailing).offset(-8)
            make.bottom.equalTo(imageView.snp.bottom).offset(-8)
            make.width.height.equalTo(32)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        
        likeButton.addTarget(self, action: #selector(likeButtonTapped), for: .touchUpInside)
        updateLikeButton()
    }
    
    
}
