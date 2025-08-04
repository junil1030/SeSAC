//
//  UIButton+Extension.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 8/4/25.
//

import UIKit

extension UIButton.Configuration {
    static func myStyle(title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.filled()
        config.title = title
        config.image = UIImage(systemName: "star.fill")
        config.baseBackgroundColor = .purple
        config.baseForegroundColor = .white
        config.cornerStyle = .capsule
        return config
    }
}
