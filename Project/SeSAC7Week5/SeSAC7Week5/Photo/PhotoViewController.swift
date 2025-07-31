//
//  PhotoViewController.swift
//  SeSAC7Week5
//
//  Created by Jack on 7/30/25.
//

import UIKit
import Alamofire

class PhotoViewController: UIViewController {
    
    var firstList: [Photo] = PhotoDummyData.firstGroup
    var secondList: [Photo] = PhotoDummyData.secondGroup
    
    lazy var tableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .orange
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PhotoTableViewCell.self, forCellReuseIdentifier: PhotoTableViewCell.identifier)
        return tableView
    }()
    
    lazy var authorTableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .blue
        tableView.rowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(AuthorTableViewCell.self, forCellReuseIdentifier: AuthorTableViewCell.identifier)
        return tableView
    }()
    
    let button = {
        let view = UIButton()
        view.setTitle("통신 시작하기", for: .normal)
        view.setTitleColor(.black, for: .normal)
        view.backgroundColor = .yellow
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
//        let group = DispatchGroup()
//        
//        group.enter()
//        self.call(url: "https://api.thecatapi.com/v1/images/search?limit=10") { response in
//            self.firstList.append(contentsOf: response)
//            print(11)
//            group.leave()
//        }
//        
//        group.enter()
//        self.call(url: "https://api.thecatapi.com/v1/images/search?limit=10") { response in
//            self.secondList.append(contentsOf: response)
//            print(22)
//            group.leave()
//        }
//        
//        group.notify(queue: .main) {
//            self.tableView.reloadData()
//            self.authorTableView.reloadData()
//        }
    }
    
    func callRequest() {
        
        let url = "https://api.thecatapi.com/v1/images/search?limit=10"
        let request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        AF.request(request)
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let value):
                    self.firstList.append(contentsOf: value)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error)
                }
                
            }
    }
    
    func callRequestAuthor() {
        let url = "https://api.thecatapi.com/v1/images/search?limit=10"
        let request = URLRequest(url: URL(string: url)!, timeoutInterval: 5)
        AF.request(request)
            .responseDecodable(of: [Photo].self) { response in
                switch response.result {
                case .success(let value):
                    self.secondList.append(contentsOf: value)
                    self.authorTableView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func call(url: String, completionHandler: @escaping ([Photo]) -> Void) {
        print(url)
        AF.request(url)
            .responseDecodable(of: [Photo].self) { reponse in
                switch reponse.result {
                case .success(let value):
                    completionHandler(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    @objc func buttonTapped() {
        let vc = DetailViewController()
//        navigationController?.pushViewController(vc, animated: true)
        let nav = UINavigationController(rootViewController: vc)
        
        vc.content = { [weak self] text in
            self?.button.setTitle(text, for: .normal)
        }
        
        present(nav, animated: true)
    }
}

extension PhotoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == authorTableView {
            return secondList.count
        } else {
            return firstList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row: String
        if tableView == authorTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: AuthorTableViewCell.identifier, for: indexPath) as! AuthorTableViewCell
            row = secondList[indexPath.row].id
            cell.authorLabel.text = row
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableViewCell.identifier, for: indexPath) as! PhotoTableViewCell
            row = firstList[indexPath.row].id
            cell.titleLabel.text = row
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, tableView)
        
        let vc = DetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
     
}

extension PhotoViewController {
    
    func configureHierarchy() {
        view.addSubview(authorTableView)
        view.addSubview(tableView)
        view.addSubview(button)
    }
    
    func configureLayout() {
         
        button.snp.makeConstraints { make in
            make.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(44)
        }
        
        tableView.snp.makeConstraints { make in
            make.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.5)
            make.top.equalTo(button.snp.bottom)
        }
        
        authorTableView.snp.makeConstraints { make in
            make.leading.equalTo(tableView.snp.trailing)
            make.verticalEdges.equalTo(tableView)
            make.trailing.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        navigationItem.title = "통신 테스트"
        view.backgroundColor = .white
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
}
