//
//  MainViewController.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    
    let lottoButton: UIButton = {
        let button = UIButton()
        button.setTitle("로또 바로가기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()
    
    let movieButton: UIButton = {
        let button = UIButton()
        button.setTitle("영화 바로가기", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 8
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    @objc private func lottoButtonTapped() {
        print(#function)
        
        let vc = LottoViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func movieButtonTapped() {
        print(#function)
        
        let vc = MovieViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(lottoButton)
        view.addSubview(movieButton)
        
        lottoButton.addTarget(self, action: #selector(lottoButtonTapped), for: .touchUpInside)
        movieButton.addTarget(self, action: #selector(movieButtonTapped), for: .touchUpInside)
    }
    
    func configureLayout() {
        lottoButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        movieButton.snp.makeConstraints { make in
            make.top.equalTo(lottoButton.snp.bottom).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
