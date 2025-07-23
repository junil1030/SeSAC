//
//  LottoBallView.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

class LottoBallView: UIView {
    
    let ballView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        return view
    }()
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    let bonusLabel: UILabel = {
        let label = UILabel()
        label.text = "보너스"
        label.textAlignment = .center
        label.textColor = .black
        label.font = .systemFont(ofSize: 10)
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        ballView.layer.cornerRadius = ballView.frame.width / 2
    }
    
    func configure(number: Int, ballType: BallType) {
        numberLabel.text = "\(number)"
        ballView.backgroundColor = ballType.color
        bonusLabel.isHidden = ballType != .bonus
    }
    
    func configurePlus() {
        numberLabel.text = "+"
        numberLabel.textColor = .black
        ballView.backgroundColor = .clear
        bonusLabel.isHidden = true
    }
}

extension LottoBallView: ViewDesignProtocol {
    func configureHierarchy() {
        addSubview(ballView)
        ballView.addSubview(numberLabel)
        addSubview(bonusLabel)
        
    }
    
    func configureLayout() {
        ballView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(ballView.snp.width)
        }
        
        numberLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        bonusLabel.snp.makeConstraints { make in
            make.top.equalTo(ballView.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
            make.bottom.lessThanOrEqualToSuperview()
        }
    }
    
    func configureView() {
        bonusLabel.isHidden = true
        
        layer.cornerRadius = frame.width / 2
        clipsToBounds = true
    }
}

enum BallType {
    case yellow
    case blue
    case red
    case black
    case green
    case bonus
    
    var color: UIColor {
        switch self {
        case .yellow:
            return .systemYellow
        case .blue:
            return .systemBlue
        case .red:
            return .systemRed
        case .black:
            return .black
        case .green:
            return .systemGreen
        case .bonus:
            return .systemGray
        }
    }
    
    static func ballType(for number: Int) -> BallType {
        switch number {
        case 1...10:
            return .yellow
        case 11...20:
            return .blue
        case 21...30:
            return .red
        case 31...40:
            return .black
        case 41...45:
            return .green
        default:
            return .bonus
        }
    }
}
