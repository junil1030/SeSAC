//
//  ViewController.swift
//  SeSAC7TestLecture
//
//  Created by 서준일 on 10/15/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var idField: UITextField!
    @IBOutlet var pwField: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signupButton: UIButton!
    @IBOutlet var resultLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let manager: NetworkProvider = NetworkManager.shared
        let viewModel = LottoViewModel(networkManager: manager)
        
        idField.accessibilityIdentifier = "login_id_field"
        pwField.accessibilityIdentifier = "login_pw_field"
        loginButton.accessibilityIdentifier = "login_btn_signin"
        resultLabel.accessibilityIdentifier = "login_label_result"
        signupButton.accessibilityIdentifier = "login_btn_signup"
    }

    @IBAction func loginButtonClicked(_ sender: Any) {
        if isValidID() && isValidPassword() {
            resultLabel.text = "로그인 성공"
        } else {
            resultLabel.text = "로그인 실패"
        }
    }
    
    func isValidID() -> Bool {
        guard let email = idField.text else { return false }
        return Validator().isValidID(email: email)
    }
    
    func isValidPassword() -> Bool {
        guard let password = pwField.text else { return false }
        return Validator().isValidPassword(password: password)
    }
}

