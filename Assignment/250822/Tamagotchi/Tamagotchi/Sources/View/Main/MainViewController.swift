//
//  MainViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/24/25.
//

import Foundation
import SnapKit

final class MainViewController: BaseViewController {
    
    let mainView = MainView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(mainView)
        mainView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
