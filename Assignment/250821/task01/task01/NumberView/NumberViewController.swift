//
//  NumberViewController.swift
//  task01
//
//  Created by 서준일 on 8/19/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class NumberViewController: UIViewController {
    
    let number1 = UITextField()
    let number2 = UITextField()
    let number3 = UITextField()
    
    let resultLabel = UILabel()
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
        setupBind()
    }

    private func setupLayout() {
        view.addSubview(number1)
        view.addSubview(number2)
        view.addSubview(number3)
        view.addSubview(resultLabel)
        
        number1.borderStyle = .roundedRect
        number1.placeholder = "첫 번째 숫자"
        
        number2.borderStyle = .roundedRect
        number2.placeholder = "두 번째 숫자"
        
        number3.borderStyle = .roundedRect
        number3.placeholder = "세 번째 숫자"
        
        resultLabel.text = "0"
        resultLabel.textAlignment = .center
        resultLabel.backgroundColor = .systemGray6
        resultLabel.layer.cornerRadius = 8
        resultLabel.clipsToBounds = true
        
        number1.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
        
        number2.snp.makeConstraints { make in
            make.top.equalTo(number1.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }

        number3.snp.makeConstraints { make in
            make.top.equalTo(number2.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }

        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(number3.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
            make.height.equalTo(44)
        }
    }
    
    private func setupBind() {
        Observable.combineLatest(number1.rx.text.orEmpty, number2.rx.text.orEmpty, number3.rx.text.orEmpty) { value1, value2, value3 -> Int in
            return (Int(value1) ?? 0) + (Int(value2) ?? 0) + (Int(value3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
}

