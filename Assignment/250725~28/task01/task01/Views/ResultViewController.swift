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
    
    private let searchKeyword: String
    
    private var filterViews: [SortType: FilterView] = [:]
    private var currentSortType: SortType = .sim
    private var currentSelectedView: FilterView?
    
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
    
    private var simLabel: FilterView!
    private var dateLabel: FilterView!
    private var ascLabel: FilterView!
    private var dscLabel: FilterView!
    
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
        
        createFilterViews()
        
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
            make.top.equalTo(filterStackView.snp.bottom).offset(10)
            make.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = searchKeyword
        searchResultCountLabel.text = "Test"
        
        setupFilterViews()
    }
    
    private func createFilterViews() {
        let sortTypes: [SortType] = [.sim, .date, .asc, .dsc]
        
        for sortType in sortTypes {
            let filterView = FilterView(sortType: sortType)
            filterViews[sortType] = filterView
            filterStackView.addArrangedSubview(filterView)
        }
    }
    
    private func setupFilterViews() {
        for (_, filterView) in filterViews {
            filterView.onTap = { [weak self] tappedSortType in
                self?.didSelectFilter(tappedSortType)
            }
        }
        
        selectFilter(.sim)
    }
    
    private func selectFilter(_ sortType: SortType) {
        currentSelectedView?.setSelected(false)
        
        let newSelectedView = filterViews[sortType]
        newSelectedView?.setSelected(true)
        
        currentSelectedView = newSelectedView
        currentSortType = sortType
    }
    
    private func didSelectFilter(_ sortType: SortType) {
        guard sortType != currentSortType else { return }
        
        selectFilter(sortType)
        loadData(sort: sortType)
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
    func loadData(sort: SortType = .sim) {
        isLoading = true
        searchResultCountLabel.text = "검색 중.."
        
        APIService.shared.searchProduct(keyword: searchKeyword, sort: sort) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isLoading = false
                
                if let response = response {
                    self.shoppingItems = response.items
                    self.totalCount = response.total
                    
                    self.searchResultCountLabel.text = "\(response.total.formattedString) 개의 검색 결과"
                    self.collectionView.reloadData()
                    
                    if !self.shoppingItems.isEmpty {
                        self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
                    }
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
