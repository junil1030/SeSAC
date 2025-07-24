//
//  MarketViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

protocol Mentor {}

class SeSAC {}
class Jack: SeSAC {}
class Bran: SeSAC, Mentor {}
class Hue {}
struct Finn {}
struct Den {}

class MarketViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MarketTableViewCell.self, forCellReuseIdentifier: MarketTableViewCell.identifier)
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
        
        callBoxOffice()
    }

    private func callRequest() {
        let url = "https://api.upbit.com/v1/market/all"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: [Coin].self) { response in
                switch response.result {
                case .success(let coin):
                    print(coin[2].korean_name)
                    print(coin[2].english_name)
                    print(coin[2].market)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
    
    private func callBoxOffice() {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=dce81509c236477e2f0dc92663417742&targetDt=20120101"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BoxOffice.self) { response in
                print(response)
                switch response.result {
                case .success(let value):
                    print(value.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}

extension MarketViewController: UITableViewDelegate {
    
    
}

extension MarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        
        return cell
    }
    
    
}

extension MarketViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
    }
    
    func configureLayout() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
    }
}
