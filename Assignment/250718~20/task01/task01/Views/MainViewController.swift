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
    
    let chatData = ChatList.list
    
    let sectionInset: CGFloat = 8
    let minimumLineSpacing: CGFloat = 8
    let column: CGFloat = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "TRAVEL TALK"
        searchBar.backgroundImage = UIImage()
        
        setupDelegate()
        registerXib()
        setupCollectionView()
    }
    
    private func registerXib() {
        let xib = UINib(nibName: ChatCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: ChatCollectionViewCell.identifier)
    }

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
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
}

extension MainViewController: UICollectionViewDelegate {
    
}

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        chatData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChatCollectionViewCell.identifier, for: indexPath) as! ChatCollectionViewCell
        
        cell.configureData(with: chatData[indexPath.item])
        return cell
    }
    
    
}
