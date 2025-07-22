//
//  MainViewController.swift
//  TravelTalkRefactoring
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UISetupProtocol {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.placeholder = "친구 이름을 검색해보세요"
        searchBar.showsBookmarkButton = false
        return searchBar
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        setupActions()
        setupDelegate()
    }

    func setupUI() {
        view.backgroundColor = .white
        
        navigationItem.title = "TRAVEL TALK"
        navigationItem.backButtonTitle = ""
        
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(3)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide.snp.horizontalEdges)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func setupActions() {
        
    }
    
    func setupDelegate() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension MainViewController: UISearchBarDelegate {
    
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        <#code#>
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        <#code#>
    }
}

