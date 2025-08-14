//
//  ARCTestDetailViewController.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/14/25.
//

import UIKit

final class ARCTestDetailViewController: UIViewController {
    
    var nickname = "고래밥"
    
    lazy var introduce = { [weak self] in
        guard let self = self else { return }
        print("안녕하세요 저는 \(self.nickname)입니다.")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .gray 
        print("ARCTestDetailViewController viewDidLoad")
        print(nickname)
        introduce()
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("ARCTestDetailViewController init")
    }
    
    deinit {
        print("ARCTestDetailViewController deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
