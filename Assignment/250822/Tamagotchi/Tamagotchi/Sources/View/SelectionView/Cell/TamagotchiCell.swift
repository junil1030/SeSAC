//
//  TamagotchiCell.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

final class TamagotchiCell: BaseCollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "준비중이에요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: ColorName.textColor)
        label.textAlignment = .center
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let imageSize = imageView.frame.width
        imageView.layer.cornerRadius = imageSize / 2
    }
    
    override func setupHierarchy() {
        contentView.addSubview(containerView)
        contentView.addSubview(titleContainerView)
        containerView.addSubview(imageView)
        titleContainerView.addSubview(titleLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(containerView)
            make.height.equalTo(imageView.snp.width)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.bottom.lessThanOrEqualToSuperview().offset(-6)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        titleLabel.layer.cornerRadius = 5
    }
    
    func configure(item: TamagotchiItem) {
        titleLabel.text = item.title
        imageView.image = UIImage(named: item.type.selectImage)
    }
}
