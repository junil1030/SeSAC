//
//  SceneDelegate.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let nav = UINavigationController(rootViewController: ViewController())
        window?.rootViewController = nav

//        if let token = UserDefaults.standard.string(forKey: "token") {
//            let rootViewController = UINavigationController(rootViewController: ProfileViewController())
//            window?.rootViewController = rootViewController
//        } else {
//            let rootViewController = UINavigationController(rootViewController: SignInViewController())
//            window?.rootViewController = rootViewController
//        }
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        print(#function)
        
        UNUserNotificationCenter.current().setBadgeCount(0)
        
        // 카톡 채팅 클릭 > 특정 친구의 채팅방으로 이동하는 기능
        // 근데 상대방이 나를 차단함.
        // 또는 단톡방이 사라졌다면
        // 카톡을 켰을 때 쌓였던 알림 목록이 다 제거
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
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

