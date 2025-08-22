//
//  BaseView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit

class BaseView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupHierachy()
        setupLayout()
        setupStyle()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupHierachy() {}
    func setupLayout() {}
    func setupStyle() {
        backgroundColor = UIColor(named: ColorName.backgroundColor)
    }
}
