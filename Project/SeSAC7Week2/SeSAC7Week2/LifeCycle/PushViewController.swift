//
//  PushViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/3/25.
//

import UIKit

class PushViewController: UIViewController {
    
    override func loadView() {
        super.loadView()
        
        print(self, #function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(self, #function)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        print(self, #function)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(self, #function)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        print(self, #function)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        print(self, #function)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print(self, #function)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print(self, #function)
    }
}
