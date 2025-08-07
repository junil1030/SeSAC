//
//  AgeViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit

//enum InputError: Error {
//    case emptyError
//    case whiteSpaceError
//    case noIntError
//    case rangeError
//    case unknownError
//    
//    var message: String {
//        switch self {
//        case .emptyError:
//            return "입력된 숫자가 없어요."
//        case .whiteSpaceError:
//            return "공백없이 입력해주세요."
//        case .noIntError:
//            return "숫자만 입력해주세요."
//        case .rangeError:
//            return  "1부터 100 사이의 숫자만 입력해주세요."
//        case .unknownError:
//            return "1부터 100 사이의 숫자를 공백없이 입력해주세요."
//        }
//    }
//}

class AgeViewController: UIViewController {
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "나이를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let label: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(textField)
        view.addSubview(resultButton)
        view.addSubview(label)
    }
    
    func configureLayout() {
        textField.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        label.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        do {
            let result = try validateUserData(textField.text, min: 1, max: 100)
            label.text = "\(result)"
        } catch let inputError as InputError {
            showToast(message: inputError.message)
        } catch {
            showToast(message: InputError.unknown.message)
        }
    }
    
}
