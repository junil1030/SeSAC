//
//  TravelTableViewController.swift
//  SeSAC7Week3
//
//  Created by 서준일 on 7/14/25.
//

import UIKit

struct Travel {
    let name: String
    let overview: String
    let date: String
    let like: Bool
}

class TravelTableViewController: UITableViewController {

    let nickname = "고래밥"
    let formatter = DateFormatter()
    
    let list = [
        Travel(name: "서울", overview: "더현대서울 좋아요", date: "250323", like: false),
        Travel(name: "대전", overview: "성심당 좋아요", date: "23018", like: false),
        Travel(name: "평택", overview: "뭐가 좋지", date: "250714", like: true),
        Travel(name: "부산", overview: "톤쇼우 좋아요", date: "241030", like: false),
        Travel(name: "강릉", overview: "쏠비치 좋아요", date: "250806", like: false),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackground()
        
        // XIB Cell로 구성하는 순간, 필요한 코드
        let xib = UINib(nibName: "TravelTableViewCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "TravelTableViewCell")
        
        tableView.rowHeight = UITableView.automaticDimension
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelTableViewCell", for: indexPath) as! TravelTableViewCell
    
        cell.configure(with: list[indexPath.row])
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }

}
