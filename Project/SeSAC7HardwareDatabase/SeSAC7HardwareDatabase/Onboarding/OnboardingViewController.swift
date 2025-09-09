//
//  OnboardingViewController.swift
//  SeSAC7HardwareDatabase
//
//  Created by 서준일 on 9/8/25.
//

import UIKit

class FirstViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
    }
}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

class ThirdViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
}

// 멤버와 값을 분리, rawValue, CaseIterable
// @unknown: 멤버가 추가될 가능성이 있는 열거형, unfrozen Enum(라이브러리, 프레임워크)
// @frozen: 절대로 멤버가 달라질 리가 없을 때 사용 ex) Optional
enum Onboarding: Int {
    case first
    case second
    case third
}

class OnboardingViewController: UIPageViewController {

    private var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        navigationItem.title = "\(getRandom())"

        list = [FirstViewController(), SecondViewController(), ThirdViewController()]
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
        delegate = self
        dataSource = self
    }
    
    // Swift Attribute
    @discardableResult
    private func getRandom() -> Int {
        let random = Int.random(in: 1...100)
        print(random)
        return random
    }

}

extension OnboardingViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first,
              let index = list.firstIndex(of: first) else {
            return 0
        }
        return index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    
}
