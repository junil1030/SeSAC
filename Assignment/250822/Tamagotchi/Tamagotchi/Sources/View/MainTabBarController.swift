//
//  MainTabBarController.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVC()
//        setupUI()
    }
    
    private func setupVC() {
        let mainVC = MainViewController()
        let mainNav = UINavigationController(rootViewController: mainVC)
        mainVC.tabBarItem = UITabBarItem(title: "Tamagotchi", image: UIImage(systemName: "gamecontroller.circle"), tag: 0)
        
        let lottoVC = UIViewController()
        let lottoNav = UINavigationController(rootViewController: lottoVC)
        lottoVC.tabBarItem = UITabBarItem(title: "Lotto", image: UIImage(systemName: "dollarsign.circle"), tag: 1)
        
        let movieVC = UIViewController()
        let movieNav = UINavigationController(rootViewController: movieVC)
        movieNav.view.backgroundColor = .black
        movieVC.tabBarItem = UITabBarItem(title: "CINEMA", image: UIImage(systemName: "popcorn"), tag: 2)
        
        viewControllers = [mainNav, lottoNav, movieNav]
    }
}
