//
//  BaseViewController.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupStyle()
        setupDelegate()
        setupBind()
    }
    
    func setupLayout() {
        navigationItem.backButtonTitle = ""
    }
    
    func setupStyle() {
        view.backgroundColor = .white
        
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.black,
            .font: UIFont.systemFont(ofSize: 20, weight: .semibold)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
    }
    
    func setupDelegate() {}
    func setupBind(){}
    
}
