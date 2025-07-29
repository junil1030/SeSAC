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
    
//    var list: [String] = ["비트코인", "이더리움", "리플", "도지코인"]
    var list: [Coin] = [
        Coin(market: "UpBit", korean_name: "비트코인", english_name: "bitcoin"),
        Coin(market: "UpBit", korean_name: "이더리움", english_name: "ethurium"),
        Coin(market: "UpBit", korean_name: "리플", english_name: "riple"),
        Coin(market: "UpBit", korean_name: "도지코인", english_name: "dodge")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        callRequest()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private func callRequest() {
        
        NetworkManager.shared.callRequest() { value in
            self.list = value
            self.tableView.reloadData()
        }
        
    }
    
//    private func callBoxOffice() {
//        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(APIConfig.kobis)&targetDt=20120101"
//        AF.request(url, method: .get)
//            .validate(statusCode: 200..<300)
//            .responseDecodable(of: BoxOffice.self) { response in
//                print(response)
//                switch response.result {
//                case .success(let value):
//                    print(value.boxOfficeResult.dailyBoxOfficeList[0].movieNm)
//                case .failure(let error):
//                    print("fail", error)
//                }
//            }
//    }
}

extension MarketViewController: UITableViewDelegate {
    
    
}

extension MarketViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableViewCell.identifier, for: indexPath) as! MarketTableViewCell
        let row = list[indexPath.row]
        cell.nameLabel.text = row.coinOverview
        cell.backgroundColor = .blue
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
