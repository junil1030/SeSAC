//
//  TransitionViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 8/1/25.
//

import UIKit
import SnapKit

protocol DataPassprotocol {
    func getRandomNumber(a: Int)
}

class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class Samsung: Mobile {
    
}

class Apple: Mobile {
    let wwdc = "wwdc25"
}

class TransitionViewController: UIViewController {
    
    private let centerButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        test()
        setupUI()
        setupConstraints()
        
        NotificationCenter.default.addObserver(self, selector: #selector(notificationReceived), name: NSNotification.Name("TextEdited"), object: nil)
    }
    
    func test() {
        
        let mobile = Mobile(name: "모바일")
        let galaxy: Mobile = Samsung(name: "갤럭시폴드7")
        let iPhone: Mobile = Apple(name: "아이폰17ProMax")
        
        if let value = iPhone as? Apple {
            value.wwdc
        }
        
        
        
        let array: [Any] = [1, 2, 3, true, "고래밥"]
        
        if let first = array[0] as? Int, let second = array[1] as? Int {
            print(first + second)
        }
    }
    
    @objc func notificationReceived(notification: NSNotification) {
        print(#function)
        
//        let text = notification.userInfo?["nickname"]
//        
//        if let text = text {
//            
//        }
    }
    
    private func setupUI() {
        view.addSubview(centerButton)
        view.backgroundColor = .white
        
        centerButton.configuration = UIButton.Configuration.myStyle(title: "중앙 버튼")
         
//        centerButton.setTitle("중앙 버튼", for: .normal)
//        centerButton.setTitleColor(.white, for: .normal)
//        centerButton.backgroundColor = .purple
//        centerButton.layer.cornerRadius = 8
         
        centerButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        // SnapKit을 사용하여 버튼을 화면 정중앙에 배치
        centerButton.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    @objc private func buttonTapped() {
        
        let vc = EditViewController()
        
        vc.jun = self
        
        vc.space = { name in
            print("안녕하세요 저는 \(name)입니다.")
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

extension TransitionViewController: DataPassprotocol {
    func getRandomNumber(a: Int) {
        print(Int.random(in: 1...a))
    }
}
