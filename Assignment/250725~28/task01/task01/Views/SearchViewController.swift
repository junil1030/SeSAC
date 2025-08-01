//
//  SearchViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit

class SearchViewController: BaseViewController {
    
    private let networkManager: NetworkManagerProtocol
    
    private let searchbar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.backgroundImage = UIImage()
        searchBar.showsCancelButton = false
        searchBar.searchTextField.textColor = .white
        searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "브랜드, 상품, 프로핑, 태그 등", attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return searchBar
    }()
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
        super.init(nibName: nil, bundle: nil, networkManager: networkManager)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        
        view.addSubview(searchbar)
    }
    
    override func configureLayout() {
        super.configureLayout()
        
        searchbar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        navigationItem.title = AppStrings.appTItle
        searchbar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, keyword.trimmingCharacters(in: .whitespacesAndNewlines).count > 1 else { return }
        
        guard checkNetworkConnection() else {
            return
        }
        
        let vc = ResultViewController(searchKeyword: keyword, networkManager: networkManager)
        navigationController?.pushViewController(vc, animated: true)
    }
}
