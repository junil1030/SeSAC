//
//  NextViewController.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 8/1/25.
//

import UIKit
import SnapKit

class NextViewController: UIViewController {
    
    var collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    
    static func layout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 100)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return layout
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .blue
        view.addSubview(collectionView)
        
        collectionView.snp.makeConstraints { make in
            make.height.equalTo(120)
            make.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.backgroundColor = .yellow
        collectionView.isPagingEnabled = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(NextCollectionViewCell.self, forCellWithReuseIdentifier: NextCollectionViewCell.identifier)
    }
}

extension NextViewController: UICollectionViewDelegate {
    
}

extension NextViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NextCollectionViewCell.identifier, for: indexPath) as! NextCollectionViewCell
        
        return cell
    }
    
    
}
