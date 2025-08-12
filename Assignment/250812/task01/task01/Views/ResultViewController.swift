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
    var isAPILoading: Bool = false
    
    private var currentPage = 1
    private let itemsPerPage = 30
    private var hasMoreData = true
    
    var recommendedItems: [ShoppingItem] = []
    var isRecommendationLoading: Bool = false
    
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
    
    let recommendationCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 140)
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(RecommendationCell.self, forCellWithReuseIdentifier: RecommendationCell.identifier)
        return collectionView
    }()
    
    let recommendationTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 상품"
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 18)
        return label
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
        loadRecommendations()
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
        
        view.addSubview(recommendationTitleLabel)
        view.addSubview(recommendationCollectionView)
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.60)
        }
        
        recommendationTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(collectionView.snp.bottom).offset(16)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.height.equalTo(24)
        }
        
        recommendationCollectionView.snp.makeConstraints { make in
            make.top.equalTo(recommendationTitleLabel.snp.bottom).offset(8)
            make.leading.trailing.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(140)
            make.bottom.lessThanOrEqualTo(view.safeAreaLayoutGuide)
        }    }
    
    override func configureView() {
        super.configureView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        recommendationCollectionView.delegate = self
        recommendationCollectionView.dataSource = self
        
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
    
    private func resetPagination() {
        totalCount = 0
        currentPage = 1
        hasMoreData = true
        shoppingItems.removeAll()
    }
    
    private func shouldLoadMoreData(for indexPath: IndexPath) -> Bool {
        return indexPath.item >= shoppingItems.count - 3 && hasMoreData && !isAPILoading
    }
}

extension ResultViewController {
    func loadData(sort: SortType = .sim, isPagination: Bool = false) {
        guard checkNetworkConnection() else {
            searchResultCountLabel.text = "네트워크 연결 없음"
            return
        }
        
        guard !isAPILoading else { return }
        
        isAPILoading = true
        
        if !isPagination {
            searchResultCountLabel.text = "검색 중.."
        }
        
        let startIndex = ((currentPage - 1) * itemsPerPage) + 1
        
        APIService.shared.searchProduct(keyword: searchKeyword, sort: sort, start: startIndex ,display: itemsPerPage) { [weak self] response in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isAPILoading = false
                
                switch response {
                case .success(let success):
                    let receivedItems = success.items
                    
                    // 받은 아이템 수가 요청한 수보다 적을 때
                    let isLastPage = self.itemsPerPage > receivedItems.count
                    
                    // 현재까지 총 로드한 아이템의 수가 전체 데이터의 수와 같거나 더 클 때 (오버해서 받아오는 경우까지 참고)
                    let totalItems = self.shoppingItems.count + receivedItems.count
                    let reachedTotal = totalItems >= success.total
                    
                    // 우연히 30으로 나누어 떨어져서 그 다음 받아온 데이터가 빈 배열일 떄
                    let isEmpty = receivedItems.isEmpty
                    
                    // 셋 중 하나라도 해당하면 마지막 페이지
                    self.hasMoreData = !isLastPage || !reachedTotal || !isEmpty
                    
                    if isPagination {
                        // 추가 로딩인 경우 기존 데이터에 새 데이터 추가
                        self.shoppingItems.append(contentsOf: receivedItems)
                        self.collectionView.reloadData()
                    } else {
                        // 새로운 검색인 경우 데이터 교체
                        self.shoppingItems = receivedItems
                        self.totalCount = success.total
                        self.collectionView.reloadData()
                        self.searchResultCountLabel.text = "\(self.totalCount.formattedString) 개의 검색 결과"
                        
                        if !self.shoppingItems.isEmpty && self.collectionView.numberOfItems(inSection: 0) > 0 {
                            DispatchQueue.main.async {
                                self.collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
                            }
                        }
                    }
                    
                    if !receivedItems.isEmpty {
                        self.currentPage += 1
                    }
                case .error(let errorCode, let error):
                    self.searchResultCountLabel.text = "검색 실패"
                    self.showAlert(type: .networkError, message: "에러: \(error)\nErrorCode: \(errorCode)")
                    self.hasMoreData = false
                }
            }
        }
    }
    
    func loadRecommendations() {
        guard checkNetworkConnection() else { return }
        guard !isRecommendationLoading else { return }
        
        isRecommendationLoading = true
        
        let randomSortType = [SortType.sim, .date, .asc, .dsc].randomElement() ?? .sim
        
        let randomPage = Int.random(in: 1...10)
        let startIndex = ((randomPage - 1) * 10) + 1
        
        APIService.shared.searchProduct(keyword: searchKeyword, sort: randomSortType, start: startIndex, display: 10) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.isRecommendationLoading = false
                
                switch result {
                case .success(let response):
                    self.recommendedItems = response.items
                    self.recommendationCollectionView.reloadData()
                case .error(let errorCode, let error):
                    self.recommendationTitleLabel.text = "검색 실패"
                    self.showAlert(type: .networkError, message: "에러: \(error)\nErrorCode: \(errorCode)")
                }
            }
        }
    }
}

extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView && shouldLoadMoreData(for: indexPath) {
            loadData(sort: currentSortType, isPagination: true)
        }
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == recommendationCollectionView {
            return recommendedItems.count
        } else {
            return shoppingItems.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == recommendationCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecommendationCell.identifier, for: indexPath) as! RecommendationCell
            let item = recommendedItems[indexPath.item]
            cell.configureData(with: item)
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
            let item = shoppingItems[indexPath.item]
            cell.configureData(with: item)
            return cell
        }
    }
}
