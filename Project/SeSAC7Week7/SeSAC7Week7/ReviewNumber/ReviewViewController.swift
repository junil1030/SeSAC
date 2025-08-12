//
//  ReviewViewController.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/12/25.
//

import UIKit

class ReviewViewModel {
    
    let text = ReviewObservable("안녕하세요")
    
    init() {
        print("ReviewViewModel Init")
        
        text.lazyBind {
            print("text bind")
        }
    }
}

class ReviewViewController: UIViewController {
    
    let number = ReviewObservable(100)
    let viewModel = ReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        view.backgroundColor = .white
        
        number.lazyBind {
            print("number bind")
            self.navigationItem.title = "\(self.number.value)"
        }
    }
}
