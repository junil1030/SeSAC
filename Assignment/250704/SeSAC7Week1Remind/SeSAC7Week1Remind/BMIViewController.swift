//
//  BMIViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 서준일 on 7/4/25.
//

import UIKit

class BMIViewController: UIViewController {
    @IBOutlet var bmiResultLabel: UILabel!
    
    @IBOutlet var heightTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    
    @IBOutlet var weightVisibleButton: UIButton!
    @IBOutlet var randomButton: UIButton!
    @IBOutlet var calcButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        bmiResultLabel.isHidden = true
        
        heightTextField.layer.cornerRadius = 10
        weightTextField.layer.cornerRadius = 10
        
        heightTextField.layer.borderWidth = 2
        weightTextField.layer.borderWidth = 2
        
        weightVisibleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        
        calcButton.layer.cornerRadius = 10
        
        weightTextField.isSecureTextEntry = true
        
        weightTextField.rightView = weightVisibleButton
        weightTextField.rightViewMode = .always
    }
    
    
    @IBAction func visibleButtonTapped(_ sender: UIButton) {
        weightTextField.isSecureTextEntry.toggle()
        
        if weightTextField.isSecureTextEntry {
            weightVisibleButton.setImage(UIImage(systemName: "eye.slash.fill"), for: .normal)
        } else {
            weightVisibleButton.setImage(UIImage(systemName: "eye.fill"), for: .normal)
        }
    }
    
    @IBAction func randomButtonTapped(_ sender: UIButton) {
        let randomHeight = Double.random(in: 100...250)
        let randomWeight = Double.random(in: 40...150)
        
        heightTextField.text = String(format: "%.1f", randomHeight)
        weightTextField.text = String(format: "%.1f", randomWeight)
    }
    
    @IBAction func calcButotnTapped(_ sender: UIButton) {
        
        guard let heightText = heightTextField.text, !heightText.isEmpty else {
            showAlert(message: "키를 입력해주세요")
            return
        }
        
        guard let height = Double(heightText), height >= 100, height <= 250 else {
            showAlert(message: "키를 100~250cm 사이로 숫자만 입력해주세요.")
            return
        }
        
        guard let weightText = weightTextField.text, !weightText.isEmpty else {
            showAlert(message: "몸무게를 입력해주세요")
            return
        }
        
        guard let weight = Double(weightText), weight >= 40, weight <= 150 else {
            showAlert(message: "40~150kg 사이로 숫자만 입력해주세요.")
            return
        }
        
        calculateBMI(height: height, weight: weight)
    }
    
    private func calculateBMI(height: Double, weight: Double) {
        let meter = height / 100.0
        let bmi = weight / (meter * meter)
        
        let category = getBMICategory(bmi)
        
        bmiResultLabel.text = String(format: "BMI: %.1f %@", bmi, category.name)
        bmiResultLabel.textColor = category.color
        bmiResultLabel.isHidden = false
    }
    
    private func getBMICategory(_ bmi: Double) -> (name: String, color: UIColor) {
        switch bmi {
        case ..<18.5:
            return ("저체중", .systemBlue)
        case ..<25:
            return ("정상체중", .systemGreen)
        case ..<30:
            return ("과체중", .systemYellow)
        default:
            return ("비만", .systemRed)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "입력 오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
