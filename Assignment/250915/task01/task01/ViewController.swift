//
//  ViewController.swift
//  task01
//
//  Created by 서준일 on 9/15/25.
//

import UIKit
import SnapKit

/*
 1. 콜렉션 뷰 생성
 2. layout 생성 (UICollectionLayoutListConfiguration, UICollectionViewCompositionalLayout)
 3. dataSource, registration 생성
 4. 초기화 해줄 함수 추가
 5. snapshot 함수 추가
 */

class ViewController: UIViewController {
    
    private enum Section: CaseIterable {
        case main
        case sub
        case caption
    }
    
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, WishList>?
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, WishList>?
    
    private var list = WishList.dummyData
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupConstraints()
        configureCellRegistration()
        updateSnapshot()
        
        searchBar.delegate = self
    }
    
    private func createLayout() -> UICollectionViewLayout {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        configuration.showsSeparators = true
        configuration.backgroundColor = .gray
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureCellRegistration() {
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.todo
            content.textProperties.color = .black
            content.secondaryText = itemIdentifier.date
            content.secondaryTextProperties.color = .white
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listCell()
            background.backgroundColor = .lightGray
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { [weak self] collectionView, indexPath, itemIdentifier in
            guard let self = self else { return UICollectionViewCell() }
            guard let registration = self.registration else { return UICollectionViewCell() }
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
            return cell
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, WishList>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: Section.main)
        
        dataSource?.apply(snapshot)
    }
    
    private func addList(todo: String) {
        guard let dataSource = dataSource else { return }
        var snapshot = dataSource.snapshot(for: .main)
        snapshot.append([WishList(todo: todo, date: Date().toString())])
        
        dataSource.apply(snapshot, to: .main)
    }
}

extension ViewController {
    private func setupUI() {
        view.backgroundColor = .white
        
        searchBar.placeholder = "할 일을 입력하세요"
        searchBar.searchBarStyle = .minimal
        view.addSubview(searchBar)
        view.addSubview(collectionView)
    }
    
    private func setupConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.leading.trailing.equalToSuperview().inset(10)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom).offset(10)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.trimmingCharacters(in: .whitespacesAndNewlines).count > 1 else { return }
        
        print(#function)
        self.addList(todo: text)
    }
}
