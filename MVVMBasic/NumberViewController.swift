//
//  NumberViewController.swift
//  SeSAC7Week6
//
//  Created by Jack on 8/8/25.
//

import UIKit
import SnapKit

class NumberViewController: UIViewController {

    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "값을 입력해주세요"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
    }
 
    @objc private func amountChanged() {
        print(#function)
        //1) 옵셔널
        guard let text = amountTextField.text else {
            formattedAmountLabel.text = ""
            formattedAmountLabel.textColor = .red
            return
        }
        
        //2) Empty
        if text.isEmpty {
            formattedAmountLabel.text = "값을 입력해주세요"
            formattedAmountLabel.textColor = .red
            return
        }
        
        //3) 숫자 여부
        guard let num = Int(text) else {
            formattedAmountLabel.text = "숫자만 입력해주세요"
            formattedAmountLabel.textColor = .red
            return
        }
        
        //4) 0 - 1,000,000
        if num > 0, num <= 1000000 {
            
            let format = NumberFormatter()
            format.numberStyle = .decimal
            let result = format.string(from: num as NSNumber)!
            formattedAmountLabel.text = "₩" + result
            formattedAmountLabel.textColor = .blue
        } else {
            formattedAmountLabel.text = "백만원 이하를 입력해주세요"
            formattedAmountLabel.textColor = .red
        }
    }
}

extension NumberViewController {
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
    }

    private func configureConstraints() {
        amountTextField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(50)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }

        formattedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(amountTextField.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }

    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }

}
