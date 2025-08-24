//
//  CustomButton.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit
import SnapKit

enum CustomButtonType {
    case drop
    case leaf
    
    var imageName: String {
        switch self {
        case .drop:
            return "drop.circle"
        case .leaf:
            return "leaf.circle"
        }
    }
}

class CustomButton: UIButton {
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.alignment = .center
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: ColorName.textColor)
        return imageView
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.text = "버튼"
        label.font = .boldSystemFont(ofSize: 12)
        label.textColor = UIColor(named: ColorName.textColor)
        label.textAlignment = .center
        return label
    }()
    
    convenience init(type: CustomButtonType, text: String) {
        self.init(frame: .zero)
        
        configure(type: type, text: text)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        layer.borderWidth = 2
        layer.borderColor = UIColor(named: ColorName.textColor)!.cgColor
        layer.cornerRadius = 12
        
        addSubview(stackView)
        stackView.addArrangedSubview(iconImageView)
        stackView.addArrangedSubview(textLabel)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        iconImageView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(iconImageView.snp.width)
        }
        
        textLabel.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.65)
        }
    }
    
    private func configure(type: CustomButtonType, text: String) {
        iconImageView.image = UIImage(systemName: type.imageName)
        textLabel.text = text
    }
}
