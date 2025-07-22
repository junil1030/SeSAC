//
//  DateCell.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit

class DateCell: UITableViewCell {
    
    static let identifier = "DateCell"
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        dateLabel.snp.makeConstraints { make in
            make.center.equalTo(contentView)
            make.verticalEdges.equalTo(contentView).inset(8)
        }
    }

    func configure(with dateString: String) {
        dateLabel.text = dateString
    }

}
