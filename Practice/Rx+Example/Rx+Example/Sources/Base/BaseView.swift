//
//  BaseView.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
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
        backgroundColor = .white
    }
}
