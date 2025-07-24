//
//  MovieViewController.swift
//  task01
//
//  Created by 서준일 on 7/23/25.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController {
    
    let movieData = MovieInfo.movies
    var filteredMovie: [Movie] = []
    
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
        getRandomMovie()
        setupKeyboardDismiss()
    }
    
    private func getRandomMovie() {
        filteredMovie.removeAll()
        filteredMovie = Array(movieData.shuffled().prefix(10))
    }
    
    private func setupKeyboardDismiss() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func searchButtonTapped() {
        getRandomMovie()
        tableView.reloadData()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
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
        getRandomMovie()
        tableView.reloadData()
    }
}

extension MovieViewController: UITableViewDelegate {
    
}

extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredMovie.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.identifier, for: indexPath) as! MovieTableViewCell
        
        cell.configureData(with: filteredMovie[indexPath.row], number: indexPath.row)
        
        return cell
    }
    
    
    
}
