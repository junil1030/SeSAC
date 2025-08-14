//
//  ARCTestViewController.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/14/25.
//

import UIKit

final class ARCTestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ARCTestViewController viewDidLoad")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = ARCTestDetailViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        print("ARCTestViewController init")
    }
    
    deinit {
        print("ARCTestViewController deinit")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
