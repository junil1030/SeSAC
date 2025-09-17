//
//  BasicColletionViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/15/25.
//

import UIKit
import SnapKit

struct Basic: Hashable, Identifiable {
    let id = UUID()
    let name: String
    let age: Int
}

class BasicCollectionViewController: UIViewController {
    
    private enum Section: CaseIterable {
        case main
        case sub
        case caption
    }
 
    private let searchBar = UISearchBar()
    private lazy var collectionView = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
    
    // <섹션을 구분하기 위한 데이터 타입, 셀의 데이터 타입>
    private var dataSource: UICollectionViewDiffableDataSource<Section, Basic>!
    private var registration: UICollectionView.CellRegistration<UICollectionViewListCell, Basic>!
    
    // Hashable한데 데이터가 같으면 어떻게 처리됨?
    private var list = [
        Basic(name: "김민수", age: 25),
        Basic(name: "이지현", age: 32),
        Basic(name: "박준호", age: 28),
        Basic(name: "최은영", age: 24),
        Basic(name: "정우진", age: 35),
        Basic(name: "강혜민", age: 29),
        Basic(name: "윤성호", age: 31),
        Basic(name: "임수정", age: 26),
        Basic(name: "송태현", age: 33),
        Basic(name: "한미영", age: 27),
        Basic(name: "조영수", age: 30),
        Basic(name: "신예린", age: 23),
        Basic(name: "오준석", age: 34),
        Basic(name: "류지민", age: 28),
        Basic(name: "문소희", age: 25),
        Basic(name: "백현우", age: 32),
        Basic(name: "홍수빈", age: 29),
        Basic(name: "서동민", age: 26),
        Basic(name: "남지우", age: 31),
        Basic(name: "안채원", age: 24),
        Basic(name: "황준영", age: 33),
        Basic(name: "노은정", age: 27),
        Basic(name: "구자영", age: 30),
        Basic(name: "전민호", age: 28),
        Basic(name: "곽유진", age: 25),
        Basic(name: "마승현", age: 34),
        Basic(name: "배소영", age: 26),
        Basic(name: "사현수", age: 31),
        Basic(name: "아름다운", age: 29),
        Basic(name: "차민지", age: 23),
        Basic(name: "카준혁", age: 32),
        Basic(name: "타예림", age: 28),
        Basic(name: "파도현", age: 25),
        Basic(name: "하윤서", age: 30),
        Basic(name: "갈수진", age: 27),
        Basic(name: "날지훈", age: 33),
        Basic(name: "달미나", age: 24),
        Basic(name: "랄성민", age: 31),
        Basic(name: "말유리", age: 26),
        Basic(name: "발준우", age: 29),
        Basic(name: "살희정", age: 32),
        Basic(name: "알동현", age: 28),
        Basic(name: "잘민영", age: 25),
        Basic(name: "찰수현", age: 34),
        Basic(name: "칼지은", age: 27),
        Basic(name: "탈준식", age: 30),
        Basic(name: "팔소정", age: 23),
        Basic(name: "할현진", age: 31),
        Basic(name: "갑미경", age: 29),
        Basic(name: "납승우", age: 26)
    ]
 
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureCellRegistration()
        updateSnapshot()
    }
    
    private func updateSnapshot() {
        
        var snapshot = NSDiffableDataSourceSnapshot<Section, Basic>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(list, toSection: .caption)
        snapshot.appendItems([
            Basic(name: "새싹이", age: 27),
            Basic(name: "새싹이", age: 14),
        ], toSection: .main)
        
        snapshot.appendItems([Basic(name: "새싹이", age: 14)], toSection: .sub)
        
        dataSource.apply(snapshot)
    }
    
    private func createLayout() -> UICollectionViewLayout {
//        let layout = UICollectionViewFlowLayout()
//        let width = UIScreen.main.bounds.width / 3 - 10
//        layout.itemSize = CGSize(width: width, height: width)
//        layout.scrollDirection = .vertical
//        return layout
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        
        configuration.showsSeparators = false
        configuration.backgroundColor = .systemYellow
        
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        
        return layout
    }
    
    private func configureCellRegistration() {
        print(#function)
        registration = UICollectionView.CellRegistration { cell, indexPath, itemIdentifier in
            print("cell registration", indexPath)
            
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.name
            content.textProperties.color = .brown
            
            content.secondaryText = "\(itemIdentifier.id)세"
            
            cell.contentConfiguration = content
            
            var background = UIBackgroundConfiguration.listGroupedCell()
            background.backgroundColor = .lightGray
            cell.backgroundConfiguration = background
        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, itemIdentifier in
            
            let cell = collectionView.dequeueConfiguredReusableCell(using: self.registration, for: indexPath, item: itemIdentifier)
            
            return cell
        }
    }
}

// Diffable을 사용하기 때문에 아예 필요가 없어짐
extension BasicCollectionViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // list[indexPath.itme] X
        let item = dataSource.itemIdentifier(for: indexPath)
        print(item)
    }
}

extension BasicCollectionViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let data = Basic(name: searchBar.text!, age: .random(in: 1...100))
        list.insert(data, at: .random(in: 0...3))
        
        updateSnapshot()
    }
}

extension BasicCollectionViewController {
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        searchBar.placeholder = "검색어를 입력하세요"
        searchBar.searchBarStyle = .minimal
        searchBar.delegate = self
        view.addSubview(searchBar)
         
        collectionView.backgroundColor = .clear
//        collectionView.register(PhotoCollectionViewCell.self, forCellWithReuseIdentifier: PhotoCollectionViewCell.id)
//        collectionView.dataSource = self
        collectionView.delegate = self
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
