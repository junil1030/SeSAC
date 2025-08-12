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
    
    //MARK: - Properties
    private let sectionInset: CGFloat = 16
    private let itemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16
    
    private var viewModel: ResultViewModel!
    
    private var filterViews: [SortType: FilterView] = [:]
    private var currentSelectedView: FilterView?
    
    //MARK: - UI Components
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
        super.init(nibName: nil, bundle: nil)
        self.viewModel = ResultViewModel(searchKeyword: searchKeyword)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        viewModel.loadData()
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
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        super.configureView()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        navigationItem.title = viewModel.getSearchKeyword()
        searchResultCountLabel.text = "Test"
        
        setupFilterViews()
    }
    
    private func setupBind() {
        viewModel.shoppingItems.bind { [weak self] items in
            self?.collectionView.reloadData()
        }
        
        viewModel.searchResultText.bind { [weak self] text in
            self?.searchResultCountLabel.text = text
        }
        
        viewModel.errorMessage.bind { [weak self] errorMessage in
            guard let errorMessage = errorMessage else { return }
            self?.showAlert(type: .networkError, message: errorMessage)
        }
        
        viewModel.currentSortType.bind { [weak self] sortType in
            self?.selectFilter(sortType)
        }
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
    }
    
    private func didSelectFilter(_ sortType: SortType) {
        guard sortType != viewModel.currentSortType.value else { return }
        
        collectionView.setContentOffset(.zero, animated: true)
        
        viewModel.loadData(sort: sortType)
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

extension ResultViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        viewModel.loadMoreDataIfNeeded(for: indexPath.item)
    }
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getItemCount()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        if let item = viewModel.getItem(at: indexPath.item) {
            cell.configureData(with: item)
        }
        
        return cell
    }
}
