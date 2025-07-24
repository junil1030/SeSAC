//
//  MovieViewController.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit
import Alamofire

class MovieViewController: UIViewController {
    
    var movieData: [DailyBoxOfficeList] = []
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "ex: 20250505"
        searchBar.searchTextField.borderStyle = .none
        searchBar.backgroundImage = UIImage()
        searchBar.keyboardType = .default
        searchBar.searchTextField.leftView = nil
        searchBar.searchTextField.leftViewMode = .never
        return searchBar
    }()
    
    let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()
    
    let searchStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        return stackView
    }()
    
    let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 44
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
        setupKeyboardDismiss()
        fetchMovieData(for: getCurrentDate())
    }
    
    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchButtonTapped() {
        if let validDateString = validateDateString(searchBar.text) {
            fetchMovieData(for: validDateString)
            tableView.reloadData()
        }
        
        tableView.reloadData()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func getCurrentDate() -> String {
        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        return formatter.string(from: yesterday)
    }
    
    private func validateDateString(_ input: String?) -> String? {
        guard let dateString = input else { return nil }
        guard dateString.count == 8 else { return nil }
        guard dateString.allSatisfy({ $0.isNumber }) else { return nil }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard formatter.date(from: dateString) != nil else { return nil }
        
        return dateString
    }
    
    private func fetchMovieData(for date: String) {
        let url = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=dce81509c236477e2f0dc92663417742&targetDt=\(date)"
        AF.request(url).responseDecodable(of: BoxOffice.self) { response in
            switch response.result {
            case .success(let movie):
                self.movieData = movie.boxOfficeResult.dailyBoxOfficeList
                self.tableView.reloadData()
            case .failure(let error):
                print("error", error)
            }
        }

    }
}

extension MovieViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(searchStackView)
        view.addSubview(underlineView)
        searchStackView.addArrangedSubview(searchBar)
        searchStackView.addArrangedSubview(searchButton)
        view.addSubview(tableView)
        
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.identifier)
        
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }
    
    func configureLayout() {
        searchStackView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.height.equalTo(60)
        }
        
        searchBar.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.7)
        }
        
        underlineView.snp.makeConstraints { make in
            make.bottom.equalTo(searchBar.snp.bottom)
            make.leading.trailing.equalTo(searchBar).inset(10)
            make.height.equalTo(3)
        }
        
        tableView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(underlineView.snp.bottom).offset(10)
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .lightGray
    }
}

extension MovieViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        view.endEditing(true)

        if let validDateString = validateDateString(searchBar.text) {
            fetchMovieData(for: validDateString)
            tableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDelegate {
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        cell.configureData(with: movieData[indexPath.row])
        
        return cell
    }
    
    
    
}
