//
//  NaverViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 서준일 on 7/6/25.
//

import UIKit

class NaverViewController: UIViewController {

    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet var okButton: UIButton!
    
    @IBOutlet var checkImage: UIImageView!
    
    @IBOutlet var menuBackgroundView: UIView!
    @IBOutlet var backgroundView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        menuBackgroundView.layer.cornerRadius = menuBackgroundView.frame.height / 2
        backgroundView.layer.cornerRadius = 15
        
        let titles = ["멤버십", "현장결제", "쿠폰"]
        
        for (index, button) in menuButtons.enumerated() {
            var config = UIButton.Configuration.plain()
            config.baseForegroundColor = .lightGray
            
            let attributedTitle = AttributedString(titles[index], attributes: AttributeContainer([
                .font: UIFont.boldSystemFont(ofSize: 16)
            ]))
            config.attributedTitle = attributedTitle
            
            button.configuration = config
            button.backgroundColor = .clear
            button.layer.cornerRadius = 10
            button.layer.masksToBounds = true
        }
        
        okButton.layer.cornerRadius = okButton.frame.height / 2
    }
    
    @IBAction func menuButtonTapped(_ sender: UIButton) {
        for button in menuButtons {
            var config = button.configuration
            if button == sender {
                button.backgroundColor = .darkGray
                config?.baseForegroundColor = .white
            } else {
                button.backgroundColor = .clear
                config?.baseForegroundColor = .lightGray
            }
            button.configuration = config
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
    @IBAction func directButton(_ sender: UIButton) {
        if checkImage.image == UIImage(systemName: "checkmark.circle.fill") {
            checkImage.image = UIImage(systemName: "checkmark.circle")
        } else {
            checkImage.image = UIImage(systemName: "checkmark.circle.fill")
        }
    }
    
}
