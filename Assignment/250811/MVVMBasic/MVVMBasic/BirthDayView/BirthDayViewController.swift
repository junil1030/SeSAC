//
//  BirthDayViewController.swift
//  MVVMBasic
//
//  Created by Finn on 8/7/25.
//

import UIKit
import SnapKit

class BirthDayViewController: UIViewController {
    
    let viewModel = BirthDayViewModel()
    
    let yearTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "년도를 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "년"
        return label
    }()
    let monthTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "월을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "월"
        return label
    }()
    let dayTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "일을 입력해주세요"
        textField.borderStyle = .roundedRect
        return textField
    }()
    let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "일"
        return label
    }()
    let resultButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle( "클릭", for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    let resultLabel: UILabel = {
        let label = UILabel()
        label.text = "여기에 결과를 보여주세요"
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        setupBind()
        
        resultButton.addTarget(self, action: #selector(resultButtonTapped), for: .touchUpInside)
    }
    
    func configureHierarchy() {
        view.addSubview(yearTextField)
        view.addSubview(yearLabel)
        view.addSubview(monthTextField)
        view.addSubview(monthLabel)
        view.addSubview(dayTextField)
        view.addSubview(dayLabel)
        view.addSubview(resultButton)
        view.addSubview(resultLabel)
    }
    
    func configureLayout() {
        yearTextField.snp.makeConstraints { make in
            make.top.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        yearLabel.snp.makeConstraints { make in
            make.centerY.equalTo(yearTextField)
            make.leading.equalTo(yearTextField.snp.trailing).offset(12)
        }
        
        monthTextField.snp.makeConstraints { make in
            make.top.equalTo(yearTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        monthLabel.snp.makeConstraints { make in
            make.centerY.equalTo(monthTextField)
            make.leading.equalTo(monthTextField.snp.trailing).offset(12)
        }
        
        dayTextField.snp.makeConstraints { make in
            make.top.equalTo(monthTextField.snp.bottom).offset(20)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.width.equalTo(200)
            make.height.equalTo(44)
        }
        
        dayLabel.snp.makeConstraints { make in
            make.centerY.equalTo(dayTextField)
            make.leading.equalTo(dayTextField.snp.trailing).offset(12)
        }
        
        resultButton.snp.makeConstraints { make in
            make.top.equalTo(dayTextField.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(resultButton.snp.bottom).offset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }
    
    private func setupBind() {
//        viewModel.onCalculationSuccess = { [weak self] result in
//            self?.resultLabel.text = result
//        }
//        
//        viewModel.onCalculationFailure = { [weak self] errorMessage in
//            self?.showToast(message: errorMessage)
//        }
        
        viewModel.calculationResult.bind { [weak self] result in
            guard let result = result else { return }
            
            switch result {
            case .success(let text):
                self?.resultLabel.text = text
                self?.resultLabel.textColor = .black
            case .failure(let error):
                // 에러 타입이 많을 때에는 어떻게 처리해야 하지
                // 여러 개의 옵저버 클로저를 옵저버블 클래스에 넣어야 하나?
                
                // 에러에 대한 메세지 자체도 사실? VM에서 해서 보내는 게 나을 것 같음
                // 뷰컨은 정말 말그대로 그려주기만 하면 되니까
                // 항상 정답은 없음. 근데 에러가 적다면 통합으로 관리하는 것도 좋을 거 같고, 각각 분리해서 지금 처럼 쓰는 것도
                // 완전히 틀리다고는 할 수 없음
                // 상황에 따라 판단해서 적용하면 좋을 것 같음
                if let inputError = error as? InputError {
                    self?.resultLabel.text = inputError.message
                } else if let dateError = error as? DateError {
                    self?.resultLabel.text = dateError.message
                } else {
                    self?.resultLabel.text = error.localizedDescription
                }
                self?.resultLabel.textColor = .red
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    @objc func resultButtonTapped() {
        view.endEditing(true)
        
        let year = yearTextField.text
        let month = monthTextField.text
        let day = dayTextField.text
        
        // 사실 문제는 이 부분....
        // 일단 텍스트 필드에 무언가가 입력되서 그 데이터를 던지는 거 자체가 하나의 이벤트라고 볼 수 있음
        // 근데 지금 형태를 보면? 각각 일어난 3개의 이벤트를 한번에 묶어서 던지고 있음
        // 이것도 어떻게 보면? 비즈니스적인 요소라고 볼 수도 있는 거임
        // 근데 문제는 이뿐만이 아님
        // validateBirthDay 함수 자체가 비즈니스적인 역할을 하는 함수임
        // 근데 뷰컨이 이걸 알고있네? 이 함수는 무조건 private 이었어야 함
        // 그래서 가장 올바른 방법은... 아니 제일 좋은 방향은...
        // 각각의 독립적인 옵저버블을 만들어서 값이 변경되면 무언가를 수행하는게 맞는 것 같다
//        viewModel.validateBirthDay(year: year, month: month, day: day)
    }
}
