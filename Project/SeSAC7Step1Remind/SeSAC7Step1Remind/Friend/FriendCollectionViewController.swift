//
//  FriendCollectionViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/17/25.
//

import UIKit
/*
 TableView -> CollectionView / row -> item
 1. collectionView 아웃렛 연결
 2. 부하직원 호출
 */
class FriendCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var myCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let xib = UINib(nibName: "FriendCollectionViewCell", bundle: nil)
        myCollectionView.register(xib, forCellWithReuseIdentifier: "FriendCollectionViewCell")
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        //셀의 너비와 높이도 설정하는 것이 필요함.3개
        let layout = UICollectionViewFlowLayout()
        let deviceWidth = UIScreen.main.bounds.width
        let cellWidth = deviceWidth - (16 * 2) - (16 * 3)
        layout.itemSize = CGSize(
            width: cellWidth/4, height: cellWidth/4)
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.minimumInteritemSpacing = 14
        layout.minimumLineSpacing = 16
        layout.scrollDirection = .vertical
        
        myCollectionView.collectionViewLayout = layout
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FriendCollectionViewCell", for: indexPath) as! FriendCollectionViewCell
        
        cell.nameLabel.text = "\(indexPath.item)"
        
        // 1. 처음에 어떻게 너비가 측정될까?
        // Constraints > Layout > Display > Update
        print("==cellForItemA==1==")
        DispatchQueue.main.async {
            print("==cellForItemA==2==")
            cell.profileImageView.layer.cornerRadius = cell.profileImageView.frame.width / 2
            cell.profileImageView.clipsToBounds = true
        }
        print("==cellForItemA==3==")
        
        return cell
    }


}
