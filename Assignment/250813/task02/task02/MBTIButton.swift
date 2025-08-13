//
//  MBTIButton.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit
import SnapKit

class MBTIButton: UIButton {
    
    private let mbtiType: String
    
    override var isSelected: Bool {
        didSet {
            updateAppearance()
        }
    }
    
    init(mbtiType: String) {
        self.mbtiType = mbtiType
        super.init(frame: .zero)
        setupButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupButton() {
        setTitle(mbtiType, for: .normal)
        setTitleColor(.black, for: .normal)
        setTitleColor(.white, for: .selected)
        titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        
        backgroundColor = .clear
        layer.cornerRadius = 20
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightGray.cgColor
        
        snp.makeConstraints { make in
            make.width.height.equalTo(40)
        }
        
        updateAppearance()
    }
    
    private func updateAppearance() {
        if isSelected {
            backgroundColor = UIColor(hex: "#186FF2")
            layer.borderColor = UIColor(hex: "#186FF2").cgColor
        } else {
            backgroundColor = .clear
            layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    
    func getMBTIType() -> String {
        return mbtiType
    }
}
