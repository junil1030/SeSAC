//
//  UpbitDetailViewController.swift
//  SeSAC7Week7
//
//  Created by 서준일 on 8/12/25.
//

import UIKit

final class UpbitDetailViewController: UIViewController {
    
    let viewModel = UpbitDetailViewModel()
    var data: Upbit?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, "viewDidLoad")
        
        view.backgroundColor = .white
            
        if let data = data {
            navigationItem.title = data.korean_name
        }
         
        // ViewController로 로직을 옮기니까 print가 되지 않음
        // bind로 전달한 함수를
        // -> 바로 실행도 하고, didSet action에 넣어둘 지
        // -> 실행하지 않고 didSet action에 넣어둘 지
        viewModel.outputTitle.bind {
            let data = self.viewModel.outputTitle.value
            self.navigationItem.title = data
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        print(self, "disappear")
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        print(self, "init")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("UpBitDetailViewController Deinit")
    }
}
