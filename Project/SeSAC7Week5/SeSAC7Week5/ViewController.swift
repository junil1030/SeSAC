//
//  ViewController.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 7/29/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let imageView = UIImageView()
    let button = UIButton()
    let s = UISwitch()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        //concurrentSync()
        //concurrentAsync()
        //serialSync()
        //serialAsync()
        
        globalQualityOfService()
    }
    
    /*
     동기:    Sync
     비동기:   ASync
     동시:    Concurrent
     직렬:    Serial
     */
    
    func globalQualityOfService() {
        // 여러 쓰레드가 골고루 일을 하다보니 작업이 끝나는데 걸리는 시간은 줄어들 수는 있지만
        // 어떤 작업이 먼저 끝날지는 알 수가 없는 상황이다...
        // 그렇다면 마지막이 언제 끝날지는 어떻게 알 수 있을까?? -> DispatchGroup을 활용하자...
        
        for i in 1...100 {
            DispatchQueue.global(qos: .background).async {
                print(i, terminator: " ")
            }
        }
        
        for i in 101...200 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }
        
        for i in 201...300 {
            DispatchQueue.global(qos: .userInteractive).async {
                print(i, terminator: " ")
            }
        }
        
        print("ENDENDENDEND")
    }
    
    func concurrentSync() { // 동기 + 동시
        print("동시 동기 START", terminator: " ")
        
        DispatchQueue.global().sync {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        print()
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("동시 동기 END")
    }
    
    func concurrentAsync() { // 비동기 + 동시
        print("동시 비동기 START", terminator: " ")
        
        for i in 1...100 {
            DispatchQueue.global().async {
                print(i, terminator: " ")
            }
        }

        print()
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("동시 비동기 END")
    }
    
    func serialAsync() { // 비동기 + 직렬
        print("직렬 비동기 START", terminator: " ")

        // 메인이 지금 받은 일은 하고 다른 일은 지금 하는 일과 상관없이 다른 손이 하고있다고 생각하면 됨.
        // 할 일을 여러 개의 손에 골고루 나누지 않고 하나의 손에 몰아서 시킴.
        DispatchQueue.main.async {
            for i in 1...100 {
                print(i, terminator: " ")
            }
        }
        
        print()
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("직렬 비동기 END")
    }
    
    func serialSync() { // 동기 + 직렬
        print("직렬 동기 START", terminator: " ")
        
        // 원래 DispatchQueue.main.sync가 되고 있다고 생각하면 됨
        // 그니까 여기서 또 쓰면 교착상태가 생기고 이게 바로 DeadLock
        for i in 1...100 {
            print(i, terminator: " ")
        }
        
        print()
        
        for i in 101...200 {
            print(i, terminator: " ")
        }
        
        print("직렬 동기 END")
    }

    
    func configureView() {
        navigationItem.title = "이제는 보이네"
        view.backgroundColor = .yellow
         
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(s)
        
        button.setTitle("사진열기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
        
        button.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        s.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        showAlert(title: "상품을 좋아요에 등록할까요?", message: "이거 ㄱㅊ?", ok: "ㄱㅊㄱㅊ") {
//            print("버튼을 클릭했어요")
//            self.view.backgroundColor = .yellow
//        }
    }
    
    @objc func buttonClicked() {
        print(#function)
        let url = URL(string: "https://apod.nasa.gov/apod/image/2507/Helix_GC_1080.jpg")!
        print("11111'")
        
        DispatchQueue.global().async {
            let data = try! Data(contentsOf: url)
            print("22222'")
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
        }
        
        print("33333'")
    }
}

