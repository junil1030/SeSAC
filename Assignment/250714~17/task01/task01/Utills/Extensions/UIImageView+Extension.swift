//
//  UIImageView+Extension.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(with urlString: String?) {
        guard let urlString, let url = URL(string: urlString) else {
            self.image = UIImage(named: "photo.circle.fill")
            return
        }

        self.kf.setImage(with: url)
    }
}
