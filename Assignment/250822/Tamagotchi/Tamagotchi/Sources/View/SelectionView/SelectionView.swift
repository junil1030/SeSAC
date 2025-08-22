//
//  SelectionView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/22/25.
//

import UIKit
import SnapKit

final class SelectionView: BaseView {
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = Size.SelectionViewSize.minimumLineSpacing
        layout.minimumInteritemSpacing = Size.SelectionViewSize.minimumInteritemSpacing
        layout.sectionInset = UIEdgeInsets(
            top: Size.SelectionViewSize.Inset.top,
            left: Size.SelectionViewSize.Inset.left,
            bottom: Size.SelectionViewSize.Inset.bottom,
            right: Size.SelectionViewSize.Inset.right
        )
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        cv.register(TamagotchiCell.self, forCellWithReuseIdentifier: TamagotchiCell.identifier)
        return cv
    }()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        addSubview(collectionView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
    }
}
