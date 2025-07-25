//
//  FilterView.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit

class FilterView: UIView {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    init(title: String) {
        super.init(frame: .zero)
        titleLabel.text = title
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FilterView: ViewDesignProtocol {
    func configureHierarchy() {
        addSubview(titleLabel)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(8)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
    }
}
