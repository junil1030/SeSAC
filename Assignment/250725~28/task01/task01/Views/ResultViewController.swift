//
//  ResultViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit
import Alamofire

class ResultViewController: BaseViewController {
    
    
    private let sectionInset: CGFloat = 16
    private let itemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16
    
    let searchKeyword: String
    let searchResultCount = 0
    
    let dummyData = DummyData.dummyData
    
    var shoppingItems: [ShoppingItem] = []
    var totalCount: Int = 0
    var isLoading: Bool = false
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.keyboardDismissMode = .onDrag
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(ProductCell.self, forCellWithReuseIdentifier: ProductCell.identifier)
        return collectionView
    }()
    
    let searchResultCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .green
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 15)
        return label
    }()
    
    let filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .fill
        stackView.spacing = 5
        return stackView
    }()
    
    let simLabel = FilterView(title: "정확도")
    let dateLabel = FilterView(title: "날짜순")
    let ascLabel = FilterView(title: "가격높은순")
    let dscLabel = FilterView(title: "가격낮은순")
    
    init(searchKeyword: String) {
        self.searchKeyword = searchKeyword
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        updateCollectionViewLayout()
    }
    
    override func configureHierarchy() {
        super.configureHierarchy()
        view.addSubview(searchResultCountLabel)
        view.addSubview(filterStackView)
        
        let views = [simLabel, dateLabel, ascLabel, dscLabel]
        views.forEach { filterStackView.addArrangedSubview($0) }
        
        view.addSubview(collectionView)
    }
    
    override func configureLayout() {
        super.configureLayout()
        searchResultCountLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(32)
        }
        
        filterStackView.snp.makeConstraints { make in
            make.top.equalTo(searchResultCountLabel.snp.bottom)
            make.leading.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(32)
            make.trailing.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(filterStackView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = searchKeyword
        searchResultCountLabel.text = "Test"
    }
    
    private func updateCollectionViewLayout() {
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout,
              collectionView.bounds.width > 0 else { return }
        
        let totalHorizontalSpacing = (sectionInset * 2) + itemSpacing
        let cellWidth = (collectionView.bounds.width - totalHorizontalSpacing) / 2
        let cellHeight: CGFloat = 280
        
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        layout.sectionInset = UIEdgeInsets(top: 16, left: sectionInset, bottom: 16, right: sectionInset)
        layout.minimumInteritemSpacing = itemSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.invalidateLayout()
    }
}

extension ResultViewController {
    func loadData() {
        isLoading = true
        searchResultCountLabel.text = "검색 중.."
        APIService.shared.searchProduct(keyword: searchKeyword) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isLoading = false
                
                if let response = response {
                    self.shoppingItems = response.items
                    self.totalCount = response.total
                    
                    self.searchResultCountLabel.text = "\(response.total)개의 상품"
                    self.collectionView.reloadData()
                } else {
                    self.searchResultCountLabel.text = "검색 실패"
                    self.showErrorMessage()
                }
            }
        }
    }
    
    private func showErrorMessage() {
        let alert = UIAlertController(title: "오류", message: "상품을 불러올 수 없습니다.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension ResultViewController: UICollectionViewDelegate {
    
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return dummyData.count
        return shoppingItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        let item = shoppingItems[indexPath.item]
        cell.configureData(with: item)
        
        return cell
    }
    
    
}
