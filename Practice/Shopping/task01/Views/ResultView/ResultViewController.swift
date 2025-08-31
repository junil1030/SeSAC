//
//  ResultViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ResultViewController: BaseViewController {
    
    //MARK: - Properties
    private let sectionInset: CGFloat = 16
    private let itemSpacing: CGFloat = 12
    private let lineSpacing: CGFloat = 16
    
    private var viewModel: ResultViewModel
    private let disposeBag = DisposeBag()
    
    private var filterViews: [SortType: FilterView] = [:]
    private var currentSelectedView: FilterView?
    
    private let sortButtonClicked = PublishSubject<SortType>()
    private let loadMoreTrigger = PublishSubject<Void>()
    
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
        self.viewModel = ResultViewModel(searchKeyword: searchKeyword)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBind()
        sortButtonClicked.onNext(.sim)
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
        
        setupFilterViews()
        setupCollectionView()
    }
    
    private func setupBind() {
        
        let input = ResultViewModel.Input(
            sortButtonClicked: sortButtonClicked.asObservable(),
            loadMoreData: loadMoreTrigger.asObserver()
        )
        
        let output = viewModel.transforom(input: input)
        
        output.items
            .drive(collectionView.rx.items(cellIdentifier: ProductCell.identifier, cellType: ProductCell.self)) { index, item, cell in
                cell.configureData(with: item)
            }
            .disposed(by: disposeBag)
        
        output.itemCount
            .drive(with: self) { owner, count in
                owner.searchResultCountLabel.text = "\(count.formattedString) 개의 검색 결과"
            }
            .disposed(by: disposeBag)
        
        output.showErrorAlert
            .drive(with: self) { owner, message in
                owner.showAlert(type: .error, message: message)
            }
            .disposed(by: disposeBag)
        
        output.title
            .drive(navigationItem.rx.title)
            .disposed(by: disposeBag)
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
                self?.sortButtonClicked.onNext(tappedSortType)
            }
        }
        
        selectFilter(.sim)
    }
    
    private func setupCollectionView() {
        collectionView.rx.willDisplayCell
            .withUnretained(self)
            .filter { owner, indexPath in
                let itemCount = self.collectionView.numberOfItems(inSection: 0)
                return indexPath.at.item >= itemCount - 3
            }
            .map { _ in }
            .bind(to: loadMoreTrigger)
            .disposed(by: disposeBag)
    }
    
    private func selectFilter(_ sortType: SortType) {
        currentSelectedView?.setSelected(false)
        
        let newSelectedView = filterViews[sortType]
        newSelectedView?.setSelected(true)
        
        currentSelectedView = newSelectedView
    }
    
    private func didSelectFilter(_ sortType: SortType) {
        selectFilter(sortType)
        collectionView.setContentOffset(.zero, animated: true)
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
