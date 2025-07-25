//
//  BaseViewController.swift
//  task01
//
//  Created by 서준일 on 7/25/25.
//

import UIKit

protocol ViewDesignProtocol: AnyObject {
    func configureHierarchy()
    func configureLayout()
    func configureView()
}

class BaseViewController: UIViewController, ViewDesignProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureHierarchy()
        configureLayout()
        configureView()
    }

    func configureHierarchy() {
        print(#function)
    }
    
    func configureLayout() {
        print(#function)
    }
    
    func configureView() {
        view.backgroundColor = .black
        navigationController?.navigationBar.tintColor = UIColor.white
        
        navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedString.Key.foregroundColor: UIColor.white
        ]
    }
}
