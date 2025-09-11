//
//  SimpleCollectionViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/11/25.
//

import UIKit
import SnapKit

class SimpleCollectionViewController: UIViewController {
    
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    private var list = ["고래밥", "칙촉", "카스타드", "치즈"]
    
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.dataSource = self
        configureDataSource()
        
    }
    
    func createLayout() -> UICollectionViewLayout {
        
        // Flow -> Compositinal -> List Configuration
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.backgroundColor = .red
        
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        
        return layout
    }
    
    func configureDataSource() {
        
        registration = UICollectionView.CellRegistration(handler: { cell, indexPath, itemIdentifier in
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier
            content.textProperties.color = .brown
            content.textProperties.font = .boldSystemFont(ofSize: 20)
            
            cell.contentConfiguration = content
            
            var backgroud = UIBackgroundConfiguration.listGroupedCell()
            backgroud.backgroundColor = .yellow
            backgroud.cornerRadius = 40
            
            cell.backgroundConfiguration = backgroud
        })
    }
    
}

extension SimpleCollectionViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    // 1. custom Cell을 구성해서 사용을 했는데 그러려면 identifier도 있어야 하고, 셀 등록도 해주어야 함
    //    custom cell + identifier + register
    // 2. system cell +     X      + CellRegistration
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: <#T##String#>, for: <#T##IndexPath#>) as!
        
        let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: list[indexPath.item])
        
        return cell
    }
    
    
}
