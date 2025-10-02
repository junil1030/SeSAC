import UIKit
import SnapKit
import RxSwift
import RxCocoa

// MARK: - UIView Extension
extension UIView {
    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
}

/// 메인 화면 ViewController
final class MainViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MainViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 24
        stackView.alignment = .fill
        return stackView
    }()
    
    private lazy var loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    // MARK: - Initialization
    init(viewModel: MainViewModel = MainViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
        bindInput()
        
        // viewDidLoad 이벤트 발생
        viewModel.input.viewDidLoad.onNext(())
    }
    
    deinit {
        print("MainViewController deallocated")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        title = "영화"
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        view.addSubview(loadingIndicator)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
        
        loadingIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    private func bindViewModel() {
        viewModel.output.isLoading
            .bind(to: loadingIndicator.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel.output.errorMessage
            .subscribe(onNext: { [weak self] message in
                self?.showError(message)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.movieSections
            .subscribe(onNext: { [weak self] sections in
                self?.updateUI(with: sections)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindInput() {
        // viewDidLoad 이벤트는 실제 viewDidLoad가 호출된 후에 발생시킵니다
        // 이 메서드는 setupUI()에서 호출되므로 여기서는 바인딩만 설정
    }
    
    private func updateUI(with sections: [MovieSection]) {
        // 기존 뷰들 제거
        stackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        // 각 섹션별로 UI 생성
        for section in sections {
            let sectionView = createSectionView(for: section)
            stackView.addArrangedSubview(sectionView)
        }
    }
    
    private func createSectionView(for section: MovieSection) -> UIView {
        let containerView = UIView()
        
        // 섹션 타이틀
        let titleLabel = UILabel()
        titleLabel.text = section.category.koreanTitle
        titleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        titleLabel.textColor = .label
        
        // 컬렉션뷰
        let collectionView = createCollectionView()
        collectionView.tag = section.category.hashValue // 섹션 구분을 위한 태그
        
        containerView.addSubview(titleLabel)
        containerView.addSubview(collectionView)
        
        titleLabel.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(280) // 셀 높이(260) + 여백(20)
        }
        
        // 컬렉션뷰 데이터 설정
        let dataSource = MovieCollectionViewDataSource(movies: section.movies)
        collectionView.dataSource = dataSource
        collectionView.delegate = dataSource
        
        // 레이아웃이 완료된 후 reloadData 호출
        DispatchQueue.main.async {
            collectionView.reloadData()
        }
        
        return containerView
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 120, height: 260)
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        layout.estimatedItemSize = CGSize(width: 120, height: 260)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        return collectionView
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

// MARK: - CollectionView DataSource & Delegate
class MovieCollectionViewDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {
    private var movies: [MovieModel] = []
    
    init(movies: [MovieModel] = []) {
        self.movies = movies
    }
    
    func updateMovies(_ movies: [MovieModel]) {
        self.movies = movies
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.identifier,
            for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: movies[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.item]
        let detailViewController = MovieDetailViewController(movie: selectedMovie)
        detailViewController.hidesBottomBarWhenPushed = true
        
        if let navigationController = collectionView.findViewController()?.navigationController {
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
