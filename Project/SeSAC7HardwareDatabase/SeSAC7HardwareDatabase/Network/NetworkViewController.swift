//
//  NetworkViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/10/25.
//

import UIKit

struct Lotto: Decodable {
    let drwNoDate: String
    let drwtNo1: Int
}

class NetworkViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
        callLotto()
    }
    
    func callLotto() {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard error == nil else {
                print("Failed Request", error)
                return
            }
            
            guard let data = data else {
                print("No Data return")
                return
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Unable Response")
                return
            }
            
            guard response.statusCode == 200 else {
                print("status code Error")
                return
            }
            
            print("이제 식판에 담을 수 있는 상태!")
            
            do {
                let result = try JSONDecoder().decode(Lotto.self, from: data)
                print("success", result)
            } catch {
                print("error")
            }
            
        }.resume()
    }

    func callRequest() {
        let url = URL(string: "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1150")!
        
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 5)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                print("오류 발생 !", error)
                return
            }
            
            // 에러가 nil이면 통신이 성공했다고 볼 수 있음
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                print("상태코드 오류가 발생 !")
                return
            }
            
            // 이제 디코딩만 하면 됨
            if let data = data {
                
                do {
                    let result = try JSONDecoder().decode(Lotto.self, from: data)
                    print(result)
                    
                    DispatchQueue.main.async {
                        self.navigationItem.title = result.drwNoDate
                    }
                    
                } catch {
                    print("디코딩 오류 발생 !")
                }
            }
        }.resume()
        
//        URLSession(configuration: .default, delegate: self, delegateQueue: .main)
    }
    
}
