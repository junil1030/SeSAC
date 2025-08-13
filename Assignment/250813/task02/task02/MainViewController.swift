//
//  MainViewController.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    private let welcomeLabel: UILabel = {
        let label = UILabel()
        label.text = "메인 화면"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "프로필 설정이 완료되었습니다!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBlue
        
        view.addSubview(welcomeLabel)
        view.addSubview(subtitleLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        welcomeLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(welcomeLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
}
