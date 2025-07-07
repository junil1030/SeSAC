//
//  DeliveryViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 서준일 on 7/6/25.
//

import UIKit

class DeliveryViewController: UIViewController {

    @IBOutlet var buttons: [UIButton]!
    @IBOutlet var images: UIImageView!
    @IBOutlet var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        searchTextField.borderStyle = .none
        searchTextField.layer.borderColor = UIColor.clear.cgColor
        searchTextField.layer.borderWidth = 0
        
        for button in buttons {
            button.layer.cornerRadius = 5
            button.layer.borderWidth = 1
            button.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        images.layer.cornerRadius = 10
    }
}
