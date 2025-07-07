//
//  ViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/3/25.
//

import UIKit

class ViewController: UIViewController {
    
    // 1. DidEndOnExit
    // 2. button
    
    override func loadView() {
        super.loadView()
        
        print(self, #function)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print(self, #function)
        
        view.backgroundColor = .red
    }
    
    // WWDC 24+, 17+에서 등장, 13+버전부터 사용가능
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        
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
    
    @IBAction func keyboardDismiss(_ sender: Any) {
        print(#function)
        view.endEditing(true)
        
    }
    
    @IBAction func myImageClicked(_ sender: Any) {
        print(#function )
    }
}

