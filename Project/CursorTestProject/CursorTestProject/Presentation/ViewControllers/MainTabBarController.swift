import UIKit

/// 메인 탭바 컨트롤러
final class MainTabBarController: UITabBarController {
    
    // MARK: - Initialization
    init() {
        super.init(nibName: nil, bundle: nil)
        setupTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    deinit {
        print("MainTabBarController deallocated")
    }
    
    // MARK: - Private Methods
    private func setupTabBar() {
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemBlue
        tabBar.unselectedItemTintColor = .systemGray
    }
    
    private func setupViewControllers() {
        let mainViewController = MainViewController()
        let searchViewController = SearchViewController()
        let favoriteViewController = FavoriteViewController()
        
        let mainNavController = UINavigationController(rootViewController: mainViewController)
        let searchNavController = UINavigationController(rootViewController: searchViewController)
        let favoriteNavController = UINavigationController(rootViewController: favoriteViewController)
        
        mainNavController.tabBarItem = UITabBarItem(
            title: "홈",
            image: UIImage(systemName: "house"),
            selectedImage: UIImage(systemName: "house.fill")
        )
        
        searchNavController.tabBarItem = UITabBarItem(
            title: "검색",
            image: UIImage(systemName: "magnifyingglass"),
            selectedImage: UIImage(systemName: "magnifyingglass")
        )
        
        favoriteNavController.tabBarItem = UITabBarItem(
            title: "즐겨찾기",
            image: UIImage(systemName: "heart"),
            selectedImage: UIImage(systemName: "heart.fill")
        )
        
        viewControllers = [mainNavController, searchNavController, favoriteNavController]
    }
}
