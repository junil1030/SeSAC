//
//  PhoneViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//
 
import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PhoneViewController: UIViewController {
   
    let phoneTextField = SignTextField(placeholderText: "연락처를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    let resultLabel = UILabel()
    
    let limitNumber = 8
    let viewModel = PhoneViewModel()
    
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
    }
    
    func bind() {
        
        let input = PhoneViewModel.Input(
            buttonTap: nextButton.rx.tap,
            text: phoneTextField.rx.text.orEmpty)
        
        let output = viewModel.transform(input: input)
        
        output.text
            .bind(with: self) { owner, text in
                owner.resultLabel.text = text
            }
            .disposed(by: disposeBag)
        
//        nextButton.rx.tap
//            .map { "버튼 클릭" }
////            .bind(with: self, onNext: { owner, value in
////                owner.resultLabel.text = value
////            })
//            .bind(to: resultLabel.rx.text)
//            .disposed(by: disposeBag)

//        nextButton.rx.tap
//            .withLatestFrom(phoneTextField.rx.text.orEmpty)
//            .map { text in
//                text.count > 8 ? "통과" : "8자 이상 입력해주세요"
//            }
//            .bind(to: resultLabel.rx.text)
//            .disposed(by: disposeBag)
        
        // 텍스트 필드가 달라질 때마다 레이블에 내용 출력
//        phoneTextField.rx.text.orEmpty
//            //.withUnretained(self) // 그래서 이걸 사용해주면 누수 방지가 가능한데 오류가 생기네? Value of type 'Binder<String?>' has no member 'orEmpty'
//            .map { $0.count >= self.limitNumber } // 이건 메모리 누수 생김
//            .bind(with: self) { owner, value in
//                owner.resultLabel.text = value ? "통과" : "8자 이상을 입력해주세요."
//            }
//            .disposed(by: disposeBag)
        
        // 왜냐하면..
        // orEmpty상태에서 map을 사용하면 넘어오는 건 String값임
        // withUnretained를 뒤에 쓰면 뭐가올까? -> transform: ((PhoneViewController, ControlProperty<String>.Element)) throws -> Result
        
        // ---최종---
//        phoneTextField.rx.text.orEmpty
//            .withUnretained(self)
//            .map { owner, text in
//                text.count >= owner.limitNumber
//            }
//            .bind(with: self) { owner, value in
//                owner.resultLabel.text = value ? "통과" : "\(owner.limitNumber)자 이상을 입력해주세요."
//            }
//            .disposed(by: disposeBag)
    }

    
    func configureLayout() {
        view.addSubview(phoneTextField)
        view.addSubview(nextButton)
        view.addSubview(resultLabel)
         
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
        
        resultLabel.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(nextButton.snp.bottom).offset(20)
        }
        
        resultLabel.text = "text"
        resultLabel.textColor = .black
        resultLabel.textAlignment = .center
    }

}
