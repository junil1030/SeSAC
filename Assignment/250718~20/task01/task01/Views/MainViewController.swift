//
//  MainViewController.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    private let chatData = ChatList.list
    private var filteredChatData: [ChatRoom] = []
    
    let sectionInset: CGFloat = 8
    let minimumLineSpacing: CGFloat = 8
    let column: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        searchBar.backgroundImage = UIImage()
        filteredChatData = chatData
        
        setupDelegate()
        registerXib()
        setupCollectionView()
        
        searchBar.placeholder = "친구 이름을 검색해보세요"
        searchBar.showsBookmarkButton = false
        
        navigationItem.backButtonTitle = ""
    }
    
    private func registerXib() {
        let xib = UINib(nibName: ChatCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)
    }

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchBar.delegate = self
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = collectionViewWidth - (sectionInset * 2)
        let cellHeight = cellWidth * 0.15
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumLineSpacing = minimumLineSpacing
        
        collectionView.collectionViewLayout = layout
    }
    
    private func searchKeyword(with keyword: String) {
        filteredChatData = chatData.filter { $0.chatroomName.contains(keyword) }
        
        collectionView.reloadData()
    }
}

extension MainViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        let currentData = filteredChatData[indexPath.item]
        
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ChatViewController.identifier) as! ChatViewController
        
        vc.chatRoomData = currentData
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredChatData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as! ChatCollectionViewCell
        
        cell.configureData(with: filteredChatData[indexPath.item])
        return cell
    }
}

extension MainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let keyword = searchBar.text, !keyword.isEmpty else {
            searchBar.resignFirstResponder()
            return
        }
        
        searchBar.resignFirstResponder()
        searchKeyword(with: keyword)
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        if searchText.isEmpty {
            filteredChatData = chatData
            collectionView.reloadData()
        } else {
            searchKeyword(with: searchText)
        }
    }
}
