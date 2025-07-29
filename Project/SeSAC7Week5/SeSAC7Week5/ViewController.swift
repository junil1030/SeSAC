//
//  ViewController.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 7/29/25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        showAlert(title: "상품을 좋아요에 등록할까요?", message: "이거 ㄱㅊ?", ok: "ㄱㅊㄱㅊ") {
            print("버튼을 클릭했어요")
            self.view.backgroundColor = .yellow
        }
    }
}

