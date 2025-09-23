//
//  AppDelegate.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/8/25.
//

import UIKit
import RealmSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        migtation()
        
        let realm = try! Realm()
        
        do {
            let version = try schemaVersionAtURL(realm.configuration.fileURL!)
            print(">>>Schema Version: \(version)")
        } catch {
            print(error)
        }
        
        
        return true
    }
    
    private func migtation() {
        
        let config = Realm.Configuration(schemaVersion: 4) { migration, oldSchemaversion in
            
            if oldSchemaversion < 1 {}
            
            // contents컬럼을 memo로 이름 변경
            if oldSchemaversion < 2 {
                migration.renameProperty(onType: Diary.className(), from: "contents", to: "memo")
            }
            
            // favorite 컬럼 추가
            if oldSchemaversion < 3 {
                migration.enumerateObjects(ofType: Diary.className()) { oldObject, newObject in
                    guard let newObject = newObject else { return }
                    newObject["favorite"] = false
                }
            }
            
            // emotion 컬럼 추가되었고, name 글자수를 emotion에 반영
            if oldSchemaversion < 4 {
                migration.enumerateObjects(ofType: Diary.className()) { oldObject, newObject in
                    guard let oldObject = oldObject else { return }
                    guard let newObject = newObject else { return }
                    
                    if let str = oldObject["name"] as? String {
                        newObject["emotion"] = Double(str.count)
                    } else {
                        newObject["emotion"] = 3
                    }
                }
            }
        }
        
        Realm.Configuration.defaultConfiguration = config
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

