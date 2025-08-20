//
//  PasswordViewController.swift
//  SeSACRxThreads
//
//  Created by jack on 2023/10/30.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PasswordViewController: UIViewController {
    
    let passwordPlaceholder = Observable.just("비밀번호를 입력해주세요")
    let nextButtonTitle = Observable.just("다음")
    
    var disposeBag = DisposeBag()
   
    let passwordTextField = SignTextField(placeholderText: "비밀번호를 입력해주세요")
    let nextButton = PointButton(title: "다음")
    
    deinit {
        print("PasswordViewController Deinit")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = Color.white
        
        configureLayout()
         
        //nextButton.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        
        aboutDispose()
        bind()
     
    }
    
    private func aboutDispose() {
        
        let array = Observable.from([1,2,3,4,5])
        
        array
            .subscribe(with: self) { owner, value in
                print("array onNext", value)
            } onError: { owner, error in
                print("array onError", error)
            } onCompleted: { owner in
                print("array onComplete")
            } onDisposed: { owner in
                print("array onDisposed")
            }
            .disposed(by: disposeBag)
        
        
        // Infinite Observable
        // next 이벤트가 무한 방출 되고 있어서, dispose 되지 않음.
        // 화면 전환이 되더라도 리소스 정리가 안되면 무한대로 실행 >> OK
        // dispose 메서드를 통해서 수동으로 일일이 정리
        // 옵저버블이 10 20 30 될 떄 수동으로 일일이 정리
        // 30개의 옵저버블을 개별적으로 정리하는 건 어렵기 때문에
        // 보통은 화면이 사라지거나 뷰컨트롤러 deinit이 될때라도 dispose
        
        var bag = DisposeBag()
        
        let text = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        text
            .subscribe(with: self) { owner, value in
                print("result onNext", value)
            } onError: { owner, error in
                print("result onError", error)
            } onCompleted: { owner in
                print("result onComplete")
            } onDisposed: { owner in
                print("result onDisposed")
            }
            .disposed(by: disposeBag)
        
        let text2 = Observable<Int>.interval(.seconds(1), scheduler: MainScheduler.instance)
        
        text2
            .subscribe(with: self) { owner, value in
                print("result2 onNext", value)
            } onError: { owner, error in
                print("result2 onError", error)
            } onCompleted: { owner in
                print("result2 onComplete")
            } onDisposed: { owner in
                print("result2 onDisposed")
            }
            .disposed(by: disposeBag)
        
        // 무한대로 방출되는 infinite observable이 수백개라면?
        // 이렇게 매번 해제를 할 거냐고... 이건 좀 비효율 적임

//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            // 다시 bag에다가 DisposeBag을 넣어주면 기존 인스턴스가 deinit이 되면서 dispose됨
//            self.disposeBag = DisposeBag()
//        }
    }
    
    private func bind() {
        /*
         1. subscribe > next error complete dispose print
         2. 순환참조 subscribe(with:)
         3. 호출되지 않는 이벤트 생략
         4. subscribe를 bind로 바꿔줘도 괜찮겠다. next ui(이벤트를 받지 못하는 bind로 변경)
         5. Rx 특성과 연결
         */
        passwordPlaceholder
            .subscribe(with: self) { owner, value in
                owner.passwordTextField.placeholder = value
            } onError: { owner, error in
                print("onError")
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
        passwordPlaceholder
            .bind(with: self) { owner, value in
                owner.passwordTextField.placeholder = value
            }
            .disposed(by: disposeBag)
        
        passwordPlaceholder
            .bind(to: passwordTextField.rx.placeholder)
            .disposed(by: disposeBag)
        
        nextButtonTitle
            .bind(to: nextButton.rx.title())
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .subscribe(with: self) { owner, _ in
                owner.navigationController?.popViewController(animated: true)
                print("button Tap", owner)
            } onError: { owner, error in
                print("button Tap onError")
            } onCompleted: { owner in
                print("button Tap onComplted")
            } onDisposed: { owner in
                print("button Tap onDisposed")
            }
            .disposed(by: disposeBag)

        
//            nextButton.rx.tap
//                .bind(with: self) { owner, _ in
//                    owner.navigationController?.pushViewController(PhoneViewController(), animated: true)
//                }
//                .disposed(by: disposeBag)
    }
    
    @objc func nextButtonClicked() {
        navigationController?.pushViewController(PhoneViewController(), animated: true)
    }
    
    func configureLayout() {
        view.addSubview(passwordTextField)
        view.addSubview(nextButton)
         
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(200)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }

}
