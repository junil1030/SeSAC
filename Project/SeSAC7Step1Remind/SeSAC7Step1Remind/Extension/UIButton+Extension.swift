//
//  UIButton+Extension.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

extension UIButton {
    
    func configure(title: String) {
        self.setTitle(title, for: .normal)
        self.setTitleColor(.black, for: .normal)
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }

    
}
