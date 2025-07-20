//
//  UpDownViewController.swift
//  task01
//
//  Created by 서준일 on 7/19/25.
//

import UIKit

class UpDownMainViewController: UIViewController {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        inputTextField.backgroundColor = .clear
        inputTextField.textAlignment = .center
        inputTextField.borderStyle = .none
        inputTextField.font = .boldSystemFont(ofSize: 24)
        
        startButton.backgroundColor = .black
        startButton.setTitleColor(.white, for: .normal)
        startButton.setTitle("시작하기", for: .normal)
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UIButton) {
    }
    
    @IBAction func startButtonTapped(_ sender: UIButton) {
        guard let number = Int(inputTextField.text ?? "") else { return }
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        if let vc = sb.instantiateViewController(withIdentifier: UpDownGameViewController.identifier) as? UpDownGameViewController {
            
            vc.numberData = number
            
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
}
