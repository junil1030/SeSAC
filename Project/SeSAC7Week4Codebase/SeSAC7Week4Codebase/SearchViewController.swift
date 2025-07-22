//
//  SearchViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/22/25.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    var myTitle: String {
        get {
            return "검색 화면"
        }
        set {
            print(newValue)
        }
    }
    
    var myButton: String {
        get {
            return "save"
        }
        set {
            
        }
    }

    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
}

extension SearchViewController: ViewDesignProtocol {
    func configureHierarchy() {
        view.addSubview(label)
    }
    
    func configureLayout() {
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(100)
        }
    }
    
    func configureView() {
        view.backgroundColor = .lightGray
        label.backgroundColor = .cyan
    }
}

extension SearchViewController: JunilNavigationProtocol {
    
    func configure() {
        navigationItem.title = myTitle
    }
}
