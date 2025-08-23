//
//  PopupView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

final class PopupView: BaseView {
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        view.clipsToBounds = true
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "준비중이에요"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: ColorName.textColor)
        label.textAlignment = .center
        return label
    }()
    
    private let lineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.textColor)
        label.text = nil
        return label
    }()
    
    private let overview: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.backgroundColor = .clear
        label.numberOfLines = 0
        return label
    }()
    
    
}
