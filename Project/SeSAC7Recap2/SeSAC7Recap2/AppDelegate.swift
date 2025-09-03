//
//  AppDelegate.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // Notification 1. 알림 권한 설정
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            print("requestAuthorization", success, error)
        }
        
        UNUserNotificationCenter.current().delegate = self
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    // 포그라운드 수신 메서드: willPresent
    // 카톡에서 친구랑 1:1 대화하는 경우 당사자 알림은 안뜨고, 다른 단톡방 알림은 뜸
    // 특정 화면, 조건에 대해서 포그라운드 알람을 받도록 할 수 있음
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
//        프로필 화면이 아닐 때에만
//        if 지금보고있는화면 is 프로필화면 {
//            
//        } else {
//            completionHandler([.sound, .badge, .banner, .list])
//        }
        
        print(notification.request.identifier)
        print(notification.request.content.title)
        print(notification.request.content.userInfo)
        
        completionHandler([.sound, .badge, .banner, .list])
    }
    
    // 사용자가 알람을 클릭했는지 알 수 있는 메서드
    // 카톡 알림이 왔을 때 그 사람이 있는 채팅방으로 바로 이동할 수 있도록
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print(response.notification.request.identifier)
        print(response.notification.request.content.title)
        print(response.notification.request.content.userInfo)
        
        let info = response.notification.request.content.userInfo
        
        if let id = info["user_id"] as? Int, let nick = info["nick"] as? String {
            // id를 가진 뷰컨트롤러로 이동
            // nick을 뷰컨트롤러 아이템 타이틀에 값 전달
            
        }
    }
}
