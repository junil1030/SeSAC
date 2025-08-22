//
//  SelectionViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

final class SelectionViewController: BaseViewController {
    
    private let selectionView = SelectionView()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "테스트"
    }

    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(selectionView)
        selectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

