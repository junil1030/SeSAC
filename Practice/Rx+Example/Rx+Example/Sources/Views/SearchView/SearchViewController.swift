//
//  SearchViewController.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import SnapKit
import RxSwift
import RxCocoa

final class SearchViewController: BaseViewController {
    
    private let searchview = SearchView()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        view.addSubview(searchview)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        searchview.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        title = "검색하기 화면"
    }
    
    override func setupBind() {
        super.setupBind()
        
    }
}
