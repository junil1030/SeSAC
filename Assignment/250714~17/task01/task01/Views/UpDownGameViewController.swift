//
//  UpDownGameViewController.swift
//  task01
//
//  Created by 서준일 on 7/19/25.
//

import UIKit

class UpDownGameViewController: UIViewController {
    
    static let identifier = "UpDownGameViewController"
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    @IBOutlet var checkButton: UIButton!
    @IBOutlet var collectionView: UICollectionView!
    
    var count = 0
    var result = -1
    var numberData: Int?
    var numbers: [Int] = []
    var selectedNumber: Int? = nil
    var isGameEnd = false
    
    let sectionInset: CGFloat = 8
    let minimumInteritemSpacing: CGFloat = 8
    let minimumLineSpacing: CGFloat = 8
    let column: CGFloat = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUp()
        setupUI()
        setupCollectionView()
        setupDelegate()
    }
    
    private func setUp() {
        if let number = numberData {
            result = Int.random(in: 1...number)
            numbers = Array(1...number)
            
            print(result)
        }
        
        let xib = UINib(nibName: UpDownGameCollectionViewCell.identifier, bundle: nil)
        collectionView.register(xib, forCellWithReuseIdentifier: UpDownGameCollectionViewCell.identifier)
    }

    private func setupUI() {
        subLabel.text = "시도횟수: \(count)"
        checkButton.setTitle("결과 확인하기", for: .normal)
        updateCheckButtonState(isEnabled: false)
    }
    
    private func updateCheckButtonState(isEnabled: Bool) {
        checkButton.isEnabled = isEnabled
        
        if isEnabled {
            checkButton.backgroundColor = .black
            checkButton.setTitleColor(.white, for: .normal)
        } else {
            checkButton.backgroundColor = .lightGray
            checkButton.setTitleColor(.white, for: .normal)
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        
        let collectionViewWidth = collectionView.bounds.width
        let cellWidth = (collectionViewWidth - (sectionInset * 2) - minimumLineSpacing - minimumInteritemSpacing) / column
        let cellHeight = cellWidth
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionInset, bottom: 0, right: sectionInset)
        layout.minimumInteritemSpacing = minimumInteritemSpacing
        layout.minimumLineSpacing = minimumLineSpacing
        layout.scrollDirection = .horizontal
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = .clear
    }
    
    private func setupDelegate() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    @IBAction func checkButtonTapped(_ sender: UIButton) {
        guard let selected = selectedNumber else { return }
        
        if selected < result {
            numbers = numbers.filter { $0 > selected }
            titleLabel.text = "UP"
            print("UP: 선택한 숫자 \(selected)")
        } else if selected > result {
            numbers = numbers.filter { $0 < selected }
            titleLabel.text = "DOWN"
            print("DOWN: 선택한 숫자 \(selected)")
        } else {
            numbers = []
            titleLabel.text = "GOOD!"
            updateCheckButtonState(isEnabled: false)
        }
        
        selectedNumber = nil
        count += 1
        subLabel.text = "시도횟수: \(count)"
        collectionView.reloadData()
        
        if !isGameEnd {
            updateCheckButtonState(isEnabled: false)
        }
    }
}

extension UpDownGameViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedNumber = numbers[indexPath.item]
        updateCheckButtonState(isEnabled: true)
    }
}

extension UpDownGameViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownGameCollectionViewCell.identifier, for: indexPath) as! UpDownGameCollectionViewCell
        
        cell.configureData(number: numbers[indexPath.item])
        
        return cell
    }
    
}
