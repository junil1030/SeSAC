import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Kingfisher

/// 영화 상세 화면 ViewController
final class MovieDetailViewController: UIViewController {
    // MARK: - Properties
    private let viewModel: MovieDetailViewModel
    private let disposeBag = DisposeBag()
    
    // MARK: - UI Components
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        return view
    }()
    
    // MARK: - Header Section
    private lazy var headerView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.alpha = 0.3
        return imageView
    }()
    
    private lazy var gradientView: UIView = {
        let view = UIView()
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    private lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        button.layer.cornerRadius = 20
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        return button
    }()
    
    // MARK: - Movie Info Section
    private lazy var movieInfoView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 20
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.backgroundColor = .systemGray5
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private lazy var ratingLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .systemOrange
        return label
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .tertiaryLabel
        return label
    }()
    
    private lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("재생", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemRed
        button.layer.cornerRadius = 25
        button.contentEdgeInsets = UIEdgeInsets(top: 12, left: 24, bottom: 12, right: 24)
        return button
    }()
    
    private lazy var overviewLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "줄거리"
        return label
    }()
    
    private lazy var overviewTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .regular)
        label.textColor = .secondaryLabel
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    init(movie: MovieModel) {
        self.viewModel = MovieDetailViewModel(movie: movie)
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
        setupGradient()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    deinit {
        print("MovieDetailViewController deallocated")
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(headerView)
        contentView.addSubview(movieInfoView)
        
        headerView.addSubview(backgroundImageView)
        headerView.addSubview(gradientView)
        headerView.addSubview(backButton)
        headerView.addSubview(favoriteButton)
        headerView.addSubview(shareButton)
        
        movieInfoView.addSubview(posterImageView)
        movieInfoView.addSubview(titleLabel)
        movieInfoView.addSubview(releaseDateLabel)
        movieInfoView.addSubview(ratingLabel)
        movieInfoView.addSubview(genreLabel)
        movieInfoView.addSubview(playButton)
        movieInfoView.addSubview(overviewLabel)
        movieInfoView.addSubview(overviewTextLabel)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalTo(400)
        }
        
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        gradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        backButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.leading.equalToSuperview().offset(16)
            make.size.equalTo(40)
        }
        
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalTo(shareButton.snp.leading).offset(-12)
            make.size.equalTo(40)
        }
        
        shareButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.trailing.equalToSuperview().offset(-16)
            make.size.equalTo(40)
        }
        
        movieInfoView.snp.makeConstraints { make in
            make.top.equalTo(headerView.snp.bottom).offset(-50)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-80)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(120)
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        releaseDateLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(releaseDateLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
        }
        
        genreLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(4)
            make.leading.equalTo(posterImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        playButton.snp.makeConstraints { make in
            make.top.equalTo(posterImageView.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.top.equalTo(playButton.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        overviewTextLabel.snp.makeConstraints { make in
            make.top.equalTo(overviewLabel.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().offset(-20)
        }
    }
    
    private func setupGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.3).cgColor,
            UIColor.black.withAlphaComponent(0.7).cgColor
        ]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        gradientView.layer.addSublayer(gradientLayer)
        
        DispatchQueue.main.async {
            gradientLayer.frame = self.gradientView.bounds
        }
    }
    
    private func bindViewModel() {
        viewModel.output.movie
            .compactMap { $0 }
            .subscribe(onNext: { [weak self] movie in
                self?.configure(with: movie)
            })
            .disposed(by: disposeBag)
        
        viewModel.output.isFavorite
            .subscribe(onNext: { [weak self] isFavorite in
                let imageName = isFavorite ? "heart.fill" : "heart"
                self?.favoriteButton.setImage(UIImage(systemName: imageName), for: .normal)
                self?.favoriteButton.tintColor = isFavorite ? .systemRed : .white
            })
            .disposed(by: disposeBag)
        
        viewModel.output.navigationEvent
            .subscribe(onNext: { [weak self] event in
                switch event {
                case .back:
                    self?.navigationController?.popViewController(animated: true)
                case .play, .share:
                    break
                }
            })
            .disposed(by: disposeBag)
        
        viewModel.output.showAlert
            .subscribe(onNext: { [weak self] message in
                self?.showAlert(message)
            })
            .disposed(by: disposeBag)
    }
    
    private func bindInput() {
        viewModel.input.viewDidLoad.onNext(())
        
        backButton.rx.tap
            .bind(to: viewModel.input.backButtonTapped)
            .disposed(by: disposeBag)
        
        playButton.rx.tap
            .bind(to: viewModel.input.playButtonTapped)
            .disposed(by: disposeBag)
        
        favoriteButton.rx.tap
            .bind(to: viewModel.input.favoriteButtonTapped)
            .disposed(by: disposeBag)
    }
    
    private func configure(with movie: MovieModel) {
        titleLabel.text = movie.title
        releaseDateLabel.text = movie.formattedReleaseDate
        ratingLabel.text = "⭐ \(String(format: "%.1f", movie.voteAverage))"
        overviewTextLabel.text = movie.overview.isEmpty ? "줄거리 정보가 없습니다." : movie.overview
        
        // 포스터 이미지 로딩
        if let posterURL = movie.posterURL {
            loadImage(from: posterURL, into: posterImageView)
        }
        
        // 배경 이미지 로딩
        if let backdropURL = movie.backdropURL {
            loadImage(from: backdropURL, into: backgroundImageView)
        }
    }
    
    private func loadImage(from url: URL, into imageView: UIImageView) {
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(systemName: "photo"),
            options: [
                .transition(.fade(0.3)),
                .cacheOriginalImage
            ]
        )
    }
    
    private func showAlert(_ message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
