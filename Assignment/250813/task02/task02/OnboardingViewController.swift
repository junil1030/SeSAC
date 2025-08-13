//
//  OnboardingViewController.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit
import SnapKit

class OnboardingViewController: UIViewController {
    
    private let logoImageView = UIImageView()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        timer = nil
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if timer == nil {
            startTimer()
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        setupLogoImageView()
        setupTitleLabel()
        setupSubtitleLabel()
        setupConstraints()
    }
    
    private func setupLogoImageView() {
        logoImageView.backgroundColor = .black
        logoImageView.layer.cornerRadius = 40
        logoImageView.clipsToBounds = true
        logoImageView.contentMode = .scaleAspectFit
        
        logoImageView.image = UIImage(systemName: "person.circle.fill")
        logoImageView.tintColor = .white
        
        view.addSubview(logoImageView)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "온보딩 화면"
        titleLabel.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        view.addSubview(titleLabel)
    }
    
    private func setupSubtitleLabel() {
        subtitleLabel.text = "2초 뒤에 바뀝니다"
        subtitleLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        subtitleLabel.textColor = .black
        subtitleLabel.textAlignment = .center
        view.addSubview(subtitleLabel)
    }
    
    private func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(40)
        }
        
        subtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.leading.trailing.equalToSuperview().inset(40)
        }
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { [weak self] _ in
            self?.navigateToProfileSetting()
        }
    }
    
    private func navigateToProfileSetting() {
        let profileSettingVC = ProfileSettingViewController()
        navigationController?.pushViewController(profileSettingVC, animated: true)
    }
}
