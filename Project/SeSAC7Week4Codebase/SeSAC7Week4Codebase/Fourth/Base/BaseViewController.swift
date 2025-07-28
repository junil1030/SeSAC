//
//  BaseViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/28/25.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupHierachy()
        setupLayout()
        setupView()
    }
    
    func setupHierachy() {
        print(self, #function)
        
    }
    
    func setupLayout() {
        print(self, #function)
        
    }
    
    func setupView() {
        print(self, #function)
        
    }
    
    func showAlert() {
        
    }
    
    func keyboardDismiss() {
        view.endEditing(true)
    }
}
