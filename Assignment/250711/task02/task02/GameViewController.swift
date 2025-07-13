//
//  ViewController.swift
//  task02
//
//  Created by 서준일 on 7/12/25.
//

import UIKit

enum InputError: Error {
    case emptyInput
    case invalidNumber
    case outOfRange
}

class GameViewController: UIViewController {

    @IBOutlet var inputTextField: UITextField!
    @IBOutlet var resultTextView: UITextView!
    @IBOutlet var resultLabel: UILabel!
    
    let maxNumber = 500
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTextField()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    func setupTextField() {
        inputTextField.placeholder = "최대 숫자를 입력해주세요"
        inputTextField.layer.borderColor = UIColor.gray.cgColor
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        do {
            let number = try convertToInt(from: sender.text)
            calculateGame(number)
        } catch {
            handleInputError(error)
        }
        
    }
    
    //MARK: - Business Logic
    
    private func calculateGame(_ number: Int) {
        var resultArray: [String] = []
        var totalClaps = 0
        
        for i in 1...number {
            let numberString = String(i)
            var convertedNumber = ""
            
            for char in numberString {
                if char == "3" || char == "6" || char == "9" {
                    convertedNumber += "👏"
                    totalClaps += 1
                } else {
                    convertedNumber += String(char)
                }
            }
            
            resultArray.append(convertedNumber)
        }
        
        resultTextView.text = resultArray.joined(separator: ", ")
        resultLabel.text = "숫자 \(number)까지 총 박수는 \(totalClaps)번 입니다."
        resultTextView.isEditable = false
        resultTextView.isSelectable = false
        resultTextView.isScrollEnabled = true
    }
    
    private func convertToInt(from text: String?) throws -> Int {
        guard let text = text, !text.isEmpty else {
            throw InputError.emptyInput
        }
        
        guard let number = Int(text) else {
            throw InputError.invalidNumber
        }
        
        guard number > 0, number <= maxNumber else {
            throw InputError.outOfRange
        }
        
        return number
    }
    
    private func handleInputError(_ error: Error) {
        var message = ""
        
        if let inputError = error as? InputError {
            switch inputError {
            case .emptyInput:
                message = "숫자를 입력해주세요"
            case .invalidNumber:
                message = "올바른 숫자를 입력해주세요"
            case .outOfRange:
                message = "0부터 \(maxNumber)까지의 숫자를 입력해주세요"
            }
        }
        
        resultLabel.text = message
        resultLabel.textColor = .red
    }
}

