//
//  FilterView.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit

enum SortType: String {
    case sim = "sim"
    case date = "date"
    case asc = "asc"
    case dsc = "dsc"
    
    var displayName: String {
        switch self {
        case .sim: return "정확도"
        case .date: return "날짜순"
        case .asc: return "가격낮은순"
        case .dsc: return "가격높은순"
        }
    }
}

class FilterView: UIView {
    let titleLabel: UILabel = {
       let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    let sortType: SortType
    private var isSelected: Bool = false {
        didSet {
            updateAppearance()
        }
    }
    
    var onTap: ((SortType) -> Void)?
    
    init(sortType: SortType) {
        self.sortType = sortType
        super.init(frame: .zero)
        titleLabel.text = sortType.displayName
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTap))
        addGestureRecognizer(tapGesture)
        isUserInteractionEnabled = true
    }
    
    @objc private func didTap() {
        onTap?(sortType)
    }
    
    func setSelected(_ selected: Bool) {
        isSelected = selected
    }
    
    private func updateAppearance() {
        UIView.animate(withDuration: 0.2) {
            if self.isSelected {
                self.backgroundColor = .white
                self.layer.borderColor = UIColor.white.cgColor
                self.titleLabel.textColor = .black
            } else {
                self.backgroundColor = .clear
                self.layer.borderColor = UIColor.white.cgColor
                self.titleLabel.textColor = .white
            }
        }
    }
}

extension FilterView: ViewDesignProtocol {
    func configureHierarchy() {
        addSubview(titleLabel)
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(5)
        }
    }
    
    func configureView() {
        backgroundColor = .clear
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
        layer.cornerRadius = 8
        
        updateAppearance()
        setupTapGesture()
    }
}
