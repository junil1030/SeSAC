//
//  PopupViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

class PopupViewController: BaseViewController {
    
    private let popupView = PopupView()
    private let selectedItem: TamagotchiItem
    
    var onStartTapped: (() -> Void)?
    var onCancelTapped: (() -> Void)?
    
    init(selectedItem: TamagotchiItem) {
        self.selectedItem = selectedItem
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        self.modalTransitionStyle = .crossDissolve
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        popupView.configure(item: selectedItem)
        setupButtonActions()
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(popupView)
        popupView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        navigationController?.navigationBar.isHidden = true
    }
    
    private func setupButtonActions() {
        popupView.startButton.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        popupView.cancelButton.addTarget(self, action: #selector(cancelButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        onStartTapped?()
        dismiss(animated: true)
    }
    
    @objc private func cancelButtonTapped() {
        onCancelTapped?()
        dismiss(animated: true)
    }
}
