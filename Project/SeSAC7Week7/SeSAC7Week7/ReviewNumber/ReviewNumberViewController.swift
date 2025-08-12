//
//  ReviewNumberViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class ReviewNumberViewController: UIViewController {
    
    private let amountTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "금액 입력"
        textField.keyboardType = .numberPad
        return textField
    }()
    private let formattedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "₩0"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    private let convertedAmountLabel: UILabel = {
        let label = UILabel()
        label.text = "$0.00"
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    let viewModel = ReviewNumberViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureConstraints()
        configureActions()
        bindData()
    }
    
    func bindData() {
        
    }
    
    
    @objc private func amountChanged() {
        print(#function)
    }
    
    func showAlert() {
        
        let alert = UIAlertController(
            title: nil,
            message: nil,
            preferredStyle: .actionSheet)
        
        
        let open = UIAlertAction(title: "확인", style: .default) { _ in
           
        }
        
        let delete = UIAlertAction(title: "삭제",
                                   style: .destructive)
        
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)
        
        
        alert.addAction(cancel)
        alert.addAction(delete)
        alert.addAction(open)
        
        
        present(alert, animated: true)
        
    }
    
    
    private func configureUI() {
        view.backgroundColor = .white
        view.addSubview(amountTextField)
        view.addSubview(formattedAmountLabel)
        view.addSubview(convertedAmountLabel)
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
        
        convertedAmountLabel.snp.makeConstraints { make in
            make.top.equalTo(formattedAmountLabel.snp.bottom).offset(20)
            make.left.right.equalTo(amountTextField)
        }
    }
    
    private func configureActions() {
        amountTextField.addTarget(self, action: #selector(amountChanged), for: .editingChanged)
    }
}
