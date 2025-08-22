//
//  BirthdayViewController2.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/21/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum junError: Error {
    case invalid
}

class BirthdayViewController2: UIViewController {
    
    let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    
    let infoLabel: UILabel = {
       let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    
    let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    
    let yearLabel: UILabel = {
       let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let monthLabel: UILabel = {
       let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    
    let dayLabel: UILabel = {
       let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
  
    let nextButton = PointButton(title: "가입하기")
    
    let viewModel = BirthdayViewModel()
    let disposeBag = DisposeBag()
//    let text = PublishSubject<String>()
        //BehaviorSubject(value: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
        bind()
        aboutBehaviorSubject()
    }
    
    func bind() {
        let input = BirthdayViewModel.Input()
        let output = viewModel.transform(input: input)
        
        birthDayPicker.rx.date
            .subscribe(with: self) { owner, date in
                owner.viewModel.date.onNext(date)
            }
            .disposed(by: disposeBag)
        
        output.year
            .observe(on: MainScheduler.instance)
            .bind(to: yearLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.month
            .asDriver(onErrorJustReturn: "OO월")
            .drive(monthLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.day
            .asDriver(onErrorJustReturn: "OO일")
            .drive(dayLabel.rx.text)
            .disposed(by: disposeBag)
    }

//    func bind() {
//        
//        // 모두 다른 숫자가 나오고 있음
//        // 근데 이건 스트림이 공유되고 있지 않다는 것이고..
//        // 버튼이 세번 클릭 되는 현상임
//        // 근데 만약 tap이 네트워크 콜을 하는 거라면?
//        // 통신을 3번이나 하게 되는 거지
//        // 그래서 스트림을 공유하는 구조를 작성해줘야함
//        
//        let _ = nextButton.rx.tap
//            .map { "랜덤 \(Int.random(in: 1...100))" }
//            .share() // 이게 스트림을 공유하는 방법임
//        
//        // 근데 드라이브를 사용하면 스트림이 공유 됨
//        let tapp = nextButton.rx.tap
//            .map { "랜덤 \(Int.random(in: 1...100))" }
//            .asDriver(onErrorJustReturn: "")
//        
//        tapp
//            .drive(yearLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        tapp
//            .drive(monthLabel.rx.text)
//            .disposed(by: disposeBag)
//        
//        tapp
//            .drive(dayLabel.rx.text)
//            .disposed(by: disposeBag)
//        
////        text
////            .asDriver(onErrorJustReturn: "unknown")
////            .drive(yearLabel.rx.text)
////            .disposed(by: disposeBag)
////        
////        nextButton.rx.tap
////            .asDriver()
////            .drive(with: self) { owner, _ in
////                owner.infoLabel.text = "입력했어요"
////                owner.text.onError(junError.invalid)
////            }
////            .disposed(by: disposeBag)
//    }
    
    func aboutBehaviorSubject() {
        
        let text = BehaviorSubject(value: "고래밥")
        
        text.onNext("칙촉")
        text.onNext("칫솔")
        
        text
            .subscribe(with: self) { owner, value in
                print("next", value)
            } onError: { owner, error in
                print("error", error)
            } onCompleted: { owner in
                print("complete")
            } onDisposed: { owner in
                print("disposed")
            }
            .disposed(by: disposeBag)
        
        text.onNext("치약")
        text.onError(junError.invalid)
        text.onNext("음료수")

    }
    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
 
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
   
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
