//
//  SearchView.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품 프로필, 태그 등"
        return searchBar
    }()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        addSubview(searchBar)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(44)
        }
    }
}
