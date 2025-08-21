//
//  SceneDelegate.swift
//  task01
//
//  Created by 서준일 on 8/19/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let numberVC = NumberViewController()
        numberVC.tabBarItem = UITabBarItem(title: "number", image: UIImage(systemName: "plus"), tag: 0)
        let numberNav = UINavigationController(rootViewController: numberVC)
        
        let validVC = ValidViewController()
        validVC.tabBarItem = UITabBarItem(title: "valid", image: UIImage(systemName: "pencil.line"), tag: 1)
        let validNav = UINavigationController(rootViewController: validVC)
        
        let tableVC = TableRxViewController()
        tableVC.tabBarItem = UITabBarItem(title: "table", image: UIImage(systemName: "tablecells"), tag: 2)
        let tableNav = UINavigationController(rootViewController: tableVC)
        
        let homeworkVC = HomeworkViewController()
        homeworkVC.tabBarItem = UITabBarItem(title: "homework", image: UIImage(systemName: "pencil.circle"), tag: 3)
        let homeworkNav = UINavigationController(rootViewController: homeworkVC)
        
        let tab = UITabBarController()
        tab.viewControllers = [numberNav, validNav, tableNav, homeworkNav]
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = tab
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

