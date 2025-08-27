//
//  ProfileDetailViweController.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/27/25.
//

import UIKit
import SnapKit
import RxSwift

final class ProfileDetailViweController: UIViewController {
    
    let viewModel: ProfileDetailViewModel
    private let disposeBag = DisposeBag()
    
    init(viewModel: ProfileDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        bind()
    }
    
    private func bind() {
        let input = ProfileDetailViewModel.Input()
        
        let output = viewModel.transform(input: input)
        
        output.navTitle
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
}
