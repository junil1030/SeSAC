//
//  Sample.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/14/25.
//

import UIKit

protocol MyDelegate {
    func sendData()
}

class MainVC: MyDelegate {
    
    lazy var customView = {
        let view = DetailView()
        view.delegate = self
        return view
    }()
    
    func sendData() {
        print("안녕하세요")
    }
    
    deinit {
        print("MainVC Deinit")
    }
}

class DetailView {
    
    var delegate: MyDelegate?
    
    deinit {
        print("DetailView Deinit")
    }
}

var view: MainVC? = MainVC()

view = nil
