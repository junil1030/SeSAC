//
//  PurpleTextField.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/23/25.
//

import UIKit

class PurpleTextField: UITextField {
    
    // 코드로 뷰를 구성했을 때 실행되는 초기화 구문
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.borderStyle = .none
        self.font = .boldSystemFont(ofSize: 15)
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.systemPurple.cgColor
        self.layer.cornerRadius = 8
        self.backgroundColor = .white
        self.tintColor = .systemPurple
    }
    
    // 스토리보드로 뷰를 구성했을 때 실행되는 초기화 구문
    // 코드로 만들더라도 스토리보드 초기화 구문은 꼭 쓰게끔 애플이 만들어놓음
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
