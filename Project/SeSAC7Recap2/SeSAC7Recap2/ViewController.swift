//
//  ViewController.swift
//  SeSAC7Recap2
//
//  Created by Jack on 8/30/25.
//

import UIKit
import SnapKit

/*
Notification 관련 정책
 - 포 그라운드에서 알림이 안뜨는 게 정상. default
 - 만약 포그라운드에서도 알림을 받고싶다면, delegate 설정으로 별도 구현
 - TimeInterval 기반 반복은 60초 이상부터 가능
 - 뱃지 숫자는 알람 갯수랑 무관. 일일이 관리 해주어야 함.
 - 알림 스택은 identifier 기준으로 쌓임
 - 64개 제한
 - 알림을 보냈다고 해서, 알림이 알림센터에 잘 전달되서 보이고 있는 지, 사용자에게 문제없이 전달되었는지는 알 수 없음..
 - -> 무슨 말이냐면,, 10만명의 사용자한테 알림을 보냅시다! 하고 보냈을 때 9만명에게만 전달되고 1만명은 유실이 됐음. 이럴 때에는 알 수 있을까?
 - 알 수 없음.. 안드는 가능한데 iOS는 다 보내졌는지는 알 수 없음. 대신 몇명이 클릭했는 지는 알 수 있음
 */

enum MyString: String {
    case navTitle = "navigation_title"
    case introduceNickname = "introduce_nick"
    case introduceAge = "introduce_age"
    case introduce = "intorcue"
}

class ViewController: UIViewController {
    
    let emailTextField = SignTextField(placeholderText: "이메일을 입력해주세요")
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let signInButton = PointButton(title: "Time 기반 로컬 알림 보내기")
    let signUpButton = PointButton(title: "Calendar 기반 로컬 알람 보내기")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        signInButton.addTarget(self, action: #selector(timeButtonClicked), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(calendarButtonClicked), for: .touchUpInside)
        
        navigationItem.title = MyString.navTitle.rawValue.localized
        
        let introduce = String(format: MyString.introduceNickname.rawValue.localized, "달봉")
        signInButton.setTitle(introduce, for: .normal)
        
        let age = String(format: MyString.introduceAge.rawValue.localized(with: "고래밥", age: 9))
        signUpButton.setTitle(age, for: .normal)
    }
    
    @objc func timeButtonClicked() {
        
        let content = UNMutableNotificationContent()
        content.title = "고래밥 \(Int.random(in: 1...100))"
        content.subtitle = "서브타이틀입니다"
        content.badge = 1
        content.body = "바디 영역입니다"
        content.userInfo = [
            "type": 1,
            "user_id": "18615016",
            "nick": "칙촉"
        ]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
//        for item in 1...100 {
            let request = UNNotificationRequest(identifier: "jun test \(UUID())", content: content, trigger: trigger)
            
            UNUserNotificationCenter.current().add(request) { error in
                print("Add Error", error)
//            }
        }
    }
    
    @objc func calendarButtonClicked() {
        let content = UNMutableNotificationContent()
        content.title = "고래밥 \(Int.random(in: 1...100))"
        content.subtitle = "서브타이틀입니다"
        content.badge = 1000
        content.body = "바디 영역입니다"
        content.userInfo = [
            "type": 1,
            "user_id": "18615016",
            "nick": "칙촉"
        ]
        
        var dateComponents = DateComponents()
        dateComponents.minute = 58
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: "jun test \(UUID())", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            print("Add Error", error)
        }
    }

    func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(emailTextField)
        view.addSubview(passwordTextField)
        view.addSubview(signInButton)
        view.addSubview(signUpButton)
        
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        signUpButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
         
    }
}
