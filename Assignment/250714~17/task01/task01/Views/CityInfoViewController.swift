//
//  CityInfoViewController.swift
//  task01
//
//  Created by 서준일 on 7/19/25.
//

import UIKit

class CityInfoViewController: UIViewController {
    
    private let cityInfo = CityInfo().city
    private var filteredCityInfo: [City] = []

    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!

    let sectionInset: CGFloat = 8
    let minimumInteritemSpacing: CGFloat = 8
    let minimumLineSpacing: CGFloat = 8
    let column: CGFloat = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "인기 도시"
        filteredCityInfo = cityInfo
        
        registerXib()
        setupDelegate()
        setupSegment()
        setupCollectionView()
    }
    
    private func registerXib() {
        let xib = UINib(nibName: CityInfoCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: CityInfoCollectionViewCell.identifier)
    }

    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func setupSegment() {
        segment.removeAllSegments()
        let segmentItems = ["모두", "국내", "해외"]
        for (index, title) in segmentItems.enumerated() {
            segment.insertSegment(withTitle: title, at: index, animated: false)
        }
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - (sectionInset * 2) - minimumLineSpacing - minimumInteritemSpacing) / column
        let cellHeight = cellWidth * 1.4
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        
        collectionView.collectionViewLayout = layout
    }
    
    private func filterCity(for index: Int) {
        switch index {
        case 1:
            filteredCityInfo = cityInfo.filter { $0.domestic_travel }
        case 2:
            filteredCityInfo = cityInfo.filter { !$0.domestic_travel }
        default:
            filteredCityInfo = cityInfo
        }
        
        collectionView.reloadData()
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        filterCity(for: sender.selectedSegmentIndex)
    }
}

extension CityInfoViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
    }
}

extension CityInfoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredCityInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCollectionViewCell.identifier, for: indexPath) as! CityInfoCollectionViewCell
        
        cell.configureData(with: filteredCityInfo[indexPath.item])
        return cell
    }
}

//extension CityInfoViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = (collectionView.bounds.width - 30) / 2
//        return CGSize(width: width, height: width * 1.4)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        UIEdgeInsets(top: 5, left: 10, bottom: 0, right: 10)
//    }
//}
