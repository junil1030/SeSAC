//
//  PhoneViewController2.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/21/25.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController2: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    let viewModel = PhoneViewModel2()
    
    let text = BehaviorSubject(value: "고래밥")
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }
    
    func bind() {
        
        let input = PhoneViewModel2.Input(buttonTap: nextButton.rx.tap)
        let output = viewModel.transform(input: input)

        // 버튼 클릭 시 Subject
        nextButton.rx.tap
            .bind(with: self) { owner, _ in
                owner.text.onNext("칙촉 \(Int.random(in: 1...100))")
            }
            .disposed(by: disposeBag)
        // 텍스트 필드에 Subject 글자 출력
        text
            .bind(to: phoneTextField.rx.text)
            .disposed(by: disposeBag)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
         
        phoneTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(phoneTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
