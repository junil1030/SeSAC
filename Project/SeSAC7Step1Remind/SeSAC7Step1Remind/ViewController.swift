//
//  ViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit
 
class ViewController: UIViewController {

    @IBOutlet var goFriendButton: UIButton!
    @IBOutlet var presentTestButton: UIButton!
    @IBOutlet var pushTestButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
          
        configureBackgroundColor()
        goFriendButton.configure(title: "Go Friend")
        presentTestButton.configure(title: "Go Present")
        pushTestButton.configure(title: "Go Push")
        
        goFriendButton.addTarget(
            self, action: #selector(goFriendButtonClicked),
                                 for: .touchUpInside)
        presentTestButton.addTarget(
            self,
            action: #selector(presentTestButtonClicked),
            for: .touchUpInside)
    }
    
    @objc //Swift Attributes (@)
    func presentTestButtonClicked() {
        print(#function)
        //1. 같은 스토리보드에서 다른 뷰컨으로 전환할 때는 스토리보드 특정 X
        //2. 어떤 뷰컨트롤러를
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TestViewController") as! TestViewController
        //이 코드가 실행될 시점에 아웃렛이 다 만들어져 있어야 문제가 없을텐데,
        //아웃렛은 스토리보드와도 결합을 해야 해서 생각보다 늦은 시점에 만들어진다.
        //화면 전환을 할 때 아웃렛을 가지고 오지는 않도록 개발을 하지 말자.
        //vc.nameLabel.text = "닉네임 \(Int.random(in: 1...100))"
        
        //Pass Data 2. contents 라는 다음 화면의 공간에 내용을 넣어주기
        vc.contents = "닉네임 \(Int.random(in: 1...100))"
        
        //3. 어떤 방식으로 전환을 할지
        present(vc, animated: true)
    }
    
    @objc
    func goFriendButtonClicked() {
        print(#function)
        //1. 어떤 스토리보드에
        let sb = UIStoryboard(name: "Friend", bundle: nil)
        //2. 어떤 뷰컨트롤러를
        let vc = sb.instantiateViewController(withIdentifier: "FriendViewController") as! FriendViewController
        //3. 어떤 방식으로 전환을 할지
        present(vc, animated: true)
    }

    
}
