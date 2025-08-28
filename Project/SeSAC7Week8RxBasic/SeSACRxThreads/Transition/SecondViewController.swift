//
//  SecondViewController.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa


class SecondViewController: UIViewController {

    let button = PointButton(title: "다음")
    let disposeBag = DisposeBag()
    
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
                let vc = ThirdViewController()
                owner.navigationController?.pushViewController(vc, animated: true)
            }.disposed(by: disposeBag)
    }
    
    deinit {
        print("Second Deinit")
    }}
