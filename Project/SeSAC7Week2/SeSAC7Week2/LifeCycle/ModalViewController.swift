//
//  ModalViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/3/25.
//

import UIKit

class ModalViewController: UIViewController {

    let nickname = "고래밥"
    
    @IBOutlet var oneButton: UIButton!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var threeButton: UIButton!
    @IBOutlet var fourButton: UIButton!
    
    @IBOutlet var resultLabel: UILabel!
    
    let list = ["자갈치", "고래밥", "칙촉", "몽쉘", "꼬북칩"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let nickname = "칙촉"
        print(nickname)
        print(self, #function)
        
        let random = list.randomElement()
        resultLabel.text = random
        
        oneButton.setTitle(list[0], for: .normal)
        twoButton.setTitle(list[1], for: .normal)
        threeButton.setTitle(list[2], for: .normal)
        fourButton.setTitle(list[3], for: .normal)
        
        oneButton.setTitleColor(.white, for: .normal)
        twoButton.setTitleColor(.white, for: .normal)
        threeButton.setTitleColor(.white, for: .normal)
        fourButton.setTitleColor(.white, for: .normal)
        
        oneButton.tag = 0
        twoButton.tag = 1
        threeButton.tag = 2
        fourButton.tag = 3
    }
    
    // Q. 하나의 액션으로 세개의 버튼을 클릭했을 때 레이블에 글자 바꾸기
    @IBAction func buttonClicked(_ sender: UIButton) {
        print(#function, sender.currentTitle!)
        
        // 1.
//        if sender == oneButton {
//            resultLabel.text = "고래밥"
//        } else if sender == twoButton {
//            resultLabel.text = "칙촉"
//        } else if sender == threeButton {
//            resultLabel.text = "카스타드"
//        } else {
//            resultLabel.text = "문제발생 ㅠㅠ"
//        }
        
        // 2.
//        resultLabel.text = sender.currentTitle!
        
        // 3.
        resultLabel.text = list[sender.tag]
    }
}
