//
//  SettingViewController.swift
//  task01
//
//  Created by 서준일 on 7/8/25.
//

import UIKit

class SettingViewController: UIViewController {

    @IBOutlet var nickNameTextField: UITextField!
    var tamagotch = TamagotchManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: Constants.baseColor
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        
        nickNameTextField.borderStyle = .none
        nickNameTextField.textColor = Constants.baseColor
    }
    
    @IBAction func saveButtonClick(_ sender: UIBarButtonItem) {
        if let name = nickNameTextField.text {
            if let validNickName = validatedNickName(name) {
                print("\(validNickName)은 \(validNickName.count)글자입니다.")
                tamagotch.nickName = validNickName
                
                showAlert(title: "저장되었습니다.", message: "")
            } else {
                showAlert(title: "입력 오류", message: "1글자 이상 6글자 이하로 입력해주세요.")
            }
        }
    }
    
    private func validatedNickName(_ nickName: String) -> String? {
        let trimmed = nickName.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmed.count >= 1 && trimmed.count <= 6 {
            return trimmed
        } else {
            return nil
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
