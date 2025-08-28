//
//  ThirdViewController.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class ThirdViewController: UIViewController {

    let button = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(button)
        
        button.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        button.rx.tap
            .bind(with: self) { owner, _ in
                
                owner.count += 1
//                if owner.count >= 3 {
//                    let vc = SecondViewController()
//                    owner.navigationController?.pushViewController(vc, animated: true)
//                }
//                self.changeRootVC()
            }.disposed(by: disposeBag)
    }
    
    private func changeRootVC() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let sceneDelegate = windowScene.delegate as? SceneDelegate else {
            return
        }
        
        guard let window = view.window else { return }
        
        sceneDelegate.window?.rootViewController = SettingViewController()
        
//        UIView.transition(with: /*==+.*/window!, duration: <#T##TimeInterval#>, animations: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)
}
    
    deinit {
        print("Third Deinit")
    }
}
