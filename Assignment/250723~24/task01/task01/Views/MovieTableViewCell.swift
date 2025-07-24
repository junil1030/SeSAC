//
//  MovieTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

class MovieTableViewCell: UITableViewCell {

    static let identifier = "MovieTableViewCell"
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .white
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let releaseLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = .clear
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        label.textAlignment = .right
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MovieTableViewCell: ViewDesignProtocol {
    func configureHierarchy() {
        contentView.addSubview(numberLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(releaseLabel)
    }
    
    func configureLayout() {
        numberLabel.snp.makeConstraints { make in
            make.verticalEdges.leading.equalToSuperview().inset(5)
            make.width.equalTo(contentView.snp.width).multipliedBy(0.15)
        }
        
        releaseLabel.snp.makeConstraints { make in
            make.verticalEdges.trailing.equalToSuperview()
            make.width.equalTo(contentView.snp.width).multipliedBy(0.25)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.verticalEdges.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(5)
            make.trailing.equalTo(releaseLabel.snp.leading).offset(-5)
        }
    }
    
    func configureView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
    }
    
    func configureData(with row: DailyBoxOfficeList) {
        numberLabel.text = "\(row.rank)"
        titleLabel.text = row.movieNm
        releaseLabel.text = row.openDt
    }
    
}
