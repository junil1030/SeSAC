//
//  BaseViewController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
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

    func setupLayout() {}
    
    func setupStyle() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .clear
        appearance.configureWithTransparentBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor(named: ColorName.textColor) ?? .black,
            .font: UIFont.boldSystemFont(ofSize: 20)
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.tintColor = UIColor(named: ColorName.textColor)
        navigationItem.backButtonTitle = ""
    }
    
    func setupDelegate() {}
    func setupBind() {}
    
    func changeRootViewController(to vc: UIViewController) {
        guard let window = view.window else { return }
        window.rootViewController = vc
    }
    
    func showAlert(title: String, message: String, completion: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default) { _ in
            completion?()
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}
