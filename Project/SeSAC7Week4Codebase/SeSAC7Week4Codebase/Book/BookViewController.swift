//
//  BookViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit
import Alamofire

class BookViewController: UIViewController {
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: BookTableViewCell.identifier)
        return tableView
    }()
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        
        return searchBar
    }()
    
    var list: BookInfo = BookInfo(items: [])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }

    func callRequest(query: String) {
        let url = "https://openapi.naver.com/v1/search/book.json?query=\(query)&display=30"
        let header: HTTPHeaders = [
            "X-Naver-Client-Id": "jcG5QoEHW8hlNn587jzF",
            "X-Naver-Client-Secret": "o_dgToMDMj"
        ]
        AF.request(url, method: .get, headers: header)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: BookInfo.self) { response in
                switch response.result {
                case .success(let value):
                    
                    self.list = value
                    self.tableView.reloadData()
                    
                case .failure(let error):
                    print("fail", error)
                }
            }
    }
}

// 콜 수 제한을 둔다.
// 실시간 검색보다는 키보드 검색 시 통신이 있는 경우가 많음
// 같은 검색어로 또 요청을 할 필요가 있을까?
extension BookViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        print(#function, searchBar.text)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        guard let query = searchBar.text, !query.isEmpty else { return }
        callRequest(query: query)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        searchBar.text = ""
        list = BookInfo(items: [])
        tableView.reloadData()
    }
}

extension BookViewController: UITableViewDelegate {
    
    
}

extension BookViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BookTableViewCell.identifier, for: indexPath) as! BookTableViewCell
        
        let row = list.items[indexPath.row]
        
        cell.titleLabel.text = row.title
        cell.subTitleLabel.text = "작가: \(row.author), 출간일: \(row.pubdate)"
        cell.overviewLabel.text = row.description
        cell.thumbnailImageView.image = UIImage(systemName: "Circle.fill")
        
        return cell
    }
}

extension BookViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(tableView)
        view.addSubview(searchBar)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(searchBar.snp.bottom)
        }
    }
    
    func configureView() {
        view.backgroundColor = .white
        tableView.rowHeight = 160
        tableView.keyboardDismissMode = .onDrag
        searchBar.delegate = self
    }
}

/*
 무한스크롤.. 페이지네이션..
 서비스적 고려사항.
 HTTP 특성, RestAPI 특성
 상태코드 예외처리
 예를 들어,
 네트워크가 끊겼거나...
 인증 콜 수를 다 썼거나...
 올바르지 않은 쿼리를 썼거나...
 즉, 200번대가 아닌 다른 번호를 어떻게 처리할래?
 try-catch, Error
 네트워크 통신은 순서가 왜 다를까? <- 비동기에 대해서
 Swift Concurrency !
 */

/*
 오늘 과제는 .... 화요일 오전까지
 
 
 
 
 */
