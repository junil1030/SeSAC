//
//  NicknameViewController.swift
//  SeSAC7Week1
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

class NicknameViewController: UIViewController {
    
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    var nickname1 = "고래밥"
    var nickname2: String = "고래밥"
    var nickname3: String = String(describing: "고래밥")
    var nickname4: String = .init("고래밥")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        resultLabel.textColor = .black
    }

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        print(#function)
        
        // 1. 읽어올 수 있는 프로퍼티, 볼 수 잇는 프로퍼티가 따로 나뉘어져 있다.
        // 2. 옵셔널 타입인지 옵셔널 타입이 아닌 지 확인 해보기
        // 3. 빈값이면 비어있어요 라고 출력하기.
        
        // \() 문자열 보간은 무조건 값이 있어야만 함
        // 공백 대응을 하기위해서는? whitespace 키워드 사용
        let text = nicknameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        
        if text.isEmpty {
            resultLabel.text = "비어있어여"
        } else {
            resultLabel.text = nicknameTextField.text
        }
    }
    
}
