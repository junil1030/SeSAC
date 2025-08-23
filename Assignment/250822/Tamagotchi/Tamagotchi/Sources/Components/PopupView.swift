//
//  PopupView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

final class PopupView: BaseView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        view.layer.cornerRadius = 16
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
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
    
    private let lineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.textColor)
        label.text = nil
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 1
        return stackView
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("취소", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: ColorName.textColor), for: .normal)
        button.setBackgroundColor(UIColor(named: ColorName.backgroundColor) ?? .white, for: .highlighted)
        button.setBackgroundColor(UIColor(named: ColorName.buttonTappedColor) ?? .blue, for: .normal)
        return button
    }()
    
    lazy var startButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("시작하기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.setTitleColor(UIColor(named: ColorName.textColor), for: .normal)
        button.setBackgroundColor(UIColor(named: ColorName.backgroundColor) ?? .white, for: .normal)
        button.setBackgroundColor(UIColor(named: ColorName.buttonTappedColor) ?? .blue, for: .highlighted)
        return button
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
    }
    
    override func setupHierachy() {
        super.setupHierachy()
        
        addSubview(containerView)
        containerView.addSubview(imageView)
        containerView.addSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        containerView.addSubview(lineLabel)
        containerView.addSubview(overview)
        containerView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(cancelButton)
        buttonStackView.addArrangedSubview(startButton)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        containerView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.5)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalToSuperview().multipliedBy(0.3)
        }
        
        titleContainerView.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(6)
            make.height.lessThanOrEqualTo(44)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        lineLabel.snp.makeConstraints { make in
            make.top.equalTo(titleContainerView.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(1)
        }
        
        overview.snp.makeConstraints { make in
            make.top.equalTo(lineLabel.snp.bottom).offset(32)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalToSuperview()
            make.height.equalTo(48)
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        self.backgroundColor = .clear
    }
    
    func configure(item: TamagotchiItem) {
        imageView.image = UIImage(named: item.type.selectImage)
        titleLabel.text = item.title
        overview.text = item.type.overView
    }
}
