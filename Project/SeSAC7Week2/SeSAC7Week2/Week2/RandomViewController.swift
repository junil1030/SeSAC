//
//  RandomViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/7/25.
//

import UIKit

class RandomViewController: UIViewController {

    @IBOutlet var randomButton: UIButton!
    @IBOutlet var randomLabel: UILabel!
    @IBOutlet var twoButton: UIButton!
    @IBOutlet var twoLabel: UILabel!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var checkButton: UIButton!
    
    let sender: [String] = ["고래밥", "칙촉", "카스타드", "초코하임", "꼬북칩"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        randomButton.setTitle("name", for: .normal)
        twoButton.setTitle("nick", for: .normal
        )
        
        randomButtonTapped(randomButton)
        twoButtonTapped(twoButton)
    }

    @IBAction func randomButtonTapped(_ sender: UIButton) {
        let result = self.sender.randomElement()
        randomLabel.text = result
    }
    
    @IBAction func twoButtonTapped(_ sender: UIButton) {
        twoLabel.text = self.sender.randomElement()
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        // 숫자인지 아닌지 확인
        
        var nick: String = "고래밥"
        
        let value = phoneTextField.text ?? "01000000000"
    }
    
    @IBAction func alertButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet
        )
        
        let ok = UIAlertAction(
            title: "OK",
            style: .default
        )
        
        let ok2 = UIAlertAction(
            title: "에러",
            style: .destructive
        )
        
        let ok3 = UIAlertAction(
            title: "OK3",
            style: .default
        )
        
        let ok4 = UIAlertAction(
            title: "취소",
            style: .cancel
        )
        
        
        alert.addAction(ok)
        alert.addAction(ok4)
        alert.addAction(ok3)
        alert.addAction(ok2)
        
        present(alert, animated: true)
    }
    
}
