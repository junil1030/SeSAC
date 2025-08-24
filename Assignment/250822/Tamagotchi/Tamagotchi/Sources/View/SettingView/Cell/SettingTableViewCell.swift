//
//  SettingTableViewCell.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import UIKit
import SnapKit

final class SettingTableViewCell: UITableViewCell {
    
    static let identifier = "SettingTableViewCell"
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = UIColor(named: ColorName.textColor)
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.textColor = UIColor(named: ColorName.textColor)
        return label
    }()
    
    private let accessoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.textAlignment = .right
        return label
    }()
    
    private let chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor(named: ColorName.backgroundColor)
        selectionStyle = .none
        
        contentView.addSubview(iconImageView)
        contentView.addSubview(titleLabel)
        contentView.addSubview(accessoryLabel)
        contentView.addSubview(chevronImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(16)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(iconImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
        }
        
        chevronImageView.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-16)
            make.centerY.equalToSuperview()
            make.width.equalTo(8)
            make.height.equalTo(12)
        }
        
        accessoryLabel.snp.makeConstraints { make in
            make.trailing.equalTo(chevronImageView.snp.leading).offset(-8)
            make.centerY.equalToSuperview()
            make.leading.greaterThanOrEqualTo(titleLabel.snp.trailing).offset(8)
        }
    }
    
    func configure(with item: SettingItem) {
        iconImageView.image = item.icon
        titleLabel.text = item.title
        accessoryLabel.text = item.accessoryText
        accessoryLabel.isHidden = item.accessoryText == nil
    }
}
