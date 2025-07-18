//
//  TestViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit

class TestViewController: UIViewController {

    @IBOutlet var nameLabel: UILabel!
    
    //Pass Data 1. 데이터를 담을 공간을 생성
    var contents: String = ""
     
    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Pass Data 3. 전달 받은 값을 뷰에 표현
        nameLabel.text = contents
        
    }
    
 
}
