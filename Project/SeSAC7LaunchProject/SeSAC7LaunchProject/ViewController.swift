//
//  ViewController.swift
//  SeSAC7LaunchProject
//
//  Created by 서준일 on 9/24/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet var oneImageView: UIImageView!
    @IBOutlet var twoImageView: UIImageView!
    @IBOutlet var threeImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let group = DispatchGroup()
        
//        group.enter()
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            print("one Image View")
//            self.oneImageView.image = image
//        }
//        
//        group.enter()
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            print("two Image View")
//            self.twoImageView.image = image
//            
//        }
//        
//        group.enter()
//        ImageNetworkManager.shared.fetchThumbnail { image in
//            print("three Image View")
//            self.oneImageView.image = image
//        }
        
        // 동기로 동작하는 구문
        //        ImageNetworkManager.shared.fetchThumbnail { image in
        //            self.oneImageView.image = image
        //        }
        
        //        ImageNetworkManager.shared.fetchThumbnailURLSession { response in
        //
        //            switch response {
        //            case .success(let success):
        //                DispatchQueue.main
        //                self.oneImageView.image = success
        //            case .failure(let failure):
        //                self.oneImageView.image = UIImage(systemName: "star,fill")
        //            }
        
        // Swift Concurrency async await
        // 비동기를 동기처럼 동작하게 만들어줄테니까, 응답이 올 때까지 걍 가만히 있으셈 ㅇㅇ
        // ?? 님아 나 viewDidLoad임 ㅋㅋ 화면 그려야되는데 너땜에 못그리면 그게 말이됨? 언제 끝날 줄 알고 하염없이 기다려
        // ??: 야야 그러면 DispatchQueue.global로 보내 ㅋㅋ
        // 어어 그렇게 연결시키지말고 그냥 내가 만들어줄게
//        Task {
//            print("one")
//            oneImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("one end")
//        }
//        Task {
//            print("two")
//            twoImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("two end")
//        }
//        Task {
//            print("three")
//            threeImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("three end")
//        }
        // 근데 이러면 알바생을 3개 만든 거임? ㄴㄴㄴㄴ 그건 CPU가 알아서 하는 거라서 우리는 모름
        
        // 그러면 순서를 무조건 보장하려면? 그니까 1 로드 끝나면 2 로드 시작 이렇게
        // 걍 Task하나에 몰빵 하면 됨
//        Task {
//            print("start")
//            oneImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("one end")
//            twoImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("two end")
//            threeImageView.image = try await ImageNetworkManager.shared.fetchAsyncAwait()
//            print("end")
//        }
        
        // 그러면 이거 GCD에 있는 DispatchGroup처럼 동시에 실행시키고 결과 한번에 못받아와?
        // 당연히 됨. 각 함수를 async로 만들고 배열 만들어서 기다리라고 하셈
        // async let(통신 갯수가 유한할 경우에는) / TaskGroup(유한하지 않을 경우)
//        Task {
//            let result = try await ImageNetworkManager.shared.fetchAsyncLet()
//            
//            oneImageView.image = result[0]
//            twoImageView.image = result[1]
//            threeImageView.image = result[2]
//        }
        
        Task {
            let result = try await ImageNetworkManager.shared.fetchTaskGroup()
            oneImageView.image = result[0]
            twoImageView.image = result[1]
            threeImageView.image = result[2]
        }
    }
}
