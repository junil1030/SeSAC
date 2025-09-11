//
//  NasaViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/11/25.
//

import UIKit
import SnapKit

enum Nasa: String, CaseIterable {
    
    static let baseURL = "https://apod.nasa.gov/apod/image/"
    
    case one = "2308/sombrero_spitzer_3000.jpg"
    case two = "2212/NGC1365-CDK24-CDK17.jpg"
    case three = "2307/M64Hubble.jpg"
    case four = "2306/BeyondEarth_Unknown_3000.jpg"
    case five = "2307/NGC6559_Block_1311.jpg"
    case six = "2304/OlympusMons_MarsExpress_6000.jpg"
    case seven = "2305/pia23122c-16.jpg"
    case eight = "2308/SunMonster_Wenz_960.jpg"
    case nine = "2307/AldrinVisor_Apollo11_4096.jpg"
    
    static var photo: URL {
        let url = Nasa.baseURL + Nasa.allCases.randomElement()!.rawValue
        print(url)
        return URL(string: url)!
    }
}

class NasaViewController: UIViewController {
    
    private var total: Double = 0.0
    private var buffer = Data()
    private let imageView = UIImageView()
    private let label = UILabel()
    private var session: URLSession!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.width.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(imageView.snp.width)
            make.center.equalTo(view)
        }
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalTo(imageView)
            make.top.equalTo(imageView.snp.bottom)
        }
        
        session = URLSession(configuration: .default, delegate: self, delegateQueue: .main)
        
        callRequestDelegate()
    }
    
    func callRequestDelegate() {
        session.dataTask(with: Nasa.photo).resume()
    }
    
    // 화면이 사라질 때, 화면 전환 할 때, 앱을 종료 하거나 뷰가 사라질 때
    // 네트워크와 관련된 리소스 정리가 필요!
    // ex) 다운로드 중에 뒤로 가기를 누르면 받아야 할까 취소해야할까 일지정지를 해야할까...
    // ex) 카톡방에서 30장 이미지를 받는 중인데, 다른 톡방을 연다면?
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        // 다운로드 중인 리소스도 무시하고
        // 화면이 사라진다면 네트워크 통신도 함께 중단하겠다.
        session.invalidateAndCancel()
        
        // 다운로드가 완료가 될 때까지 기다렸다가 다운로드가 완료되면 리소스를 정리
        session.finishTasksAndInvalidate()
        
        
    }
    
    func callRequest() {
        print(#function)
        
        URLSession.shared.dataTask(with: Nasa.photo) { data, respones, error in
            print(">>>>", data)
            // completionHandler는 100% 완료되기 전까지는 신호를 받지 못함
            // 100%가 완료되고 나서 단 한번만 클로저가 실행됨
            // 100mb를 10초동안 받는다는 가정 하에 9.9초까지 어떤 신호도 받지 못함
        }.resume()
    }
}

extension NasaViewController: URLSessionDataDelegate {
    
    // 1. 서버에서 최초로 응답 받은 경우에 호출 (상태 코드에 대한 확인)
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        print("111")
        
        if let response = response as? HTTPURLResponse, response.statusCode == 200 {
            
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            print(">>>총 데이터>>>", contentLength)
            
            total = Double(contentLength)!
            
            completionHandler(.allow)
        } else {
            completionHandler(.cancel)
        }
    }
    
    // 2. 서버에서 데이터를 받아올 때마다 반복적으로 호출 (data
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        print("222", data)
        
        buffer.append(data)
        
        let result = Double(buffer.count) / total
        
        label.text = "다운로드 중... \(String(format: "%.2f", result * 100))%"
        
        navigationItem.title = "\(buffer)"
    }
    
    // 3. 오류가 발생했거나 응답이 완료과 될 때 호출 (100%)
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        print("333", error)
        
        print(buffer)
        imageView.image = UIImage(data: buffer)
        label.text = "다운로드 완료!"
    }
}
