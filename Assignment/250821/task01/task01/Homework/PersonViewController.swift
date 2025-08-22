//
//  PersonViewController.swift
//  task01
//
//  Created by 서준일 on 8/22/25.
//

import UIKit

final class PersonViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .cyan
    }
    
    convenience init(title: String) {
        self.init(nibName: nil, bundle: nil)
        navigationItem.title = title
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
