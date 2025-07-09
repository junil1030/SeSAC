//
//  TamaDetailViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/9/25.
//

import UIKit

class TamaDetailViewController: UIViewController {

    @IBOutlet var nickNameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)

        nickNameTextField.backgroundColor = .blue
        nickNameTextField.tintColor = .red
        nickNameTextField.placeholder = "입력해주세요 닉네임"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
    }

    @IBAction func testButtonClicked(_ sender: UIBarButtonItem) {
        print(#function)
    }
}
