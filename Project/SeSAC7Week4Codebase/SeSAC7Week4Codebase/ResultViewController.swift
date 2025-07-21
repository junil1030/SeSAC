//
//  ResultViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/21/25.
//

import UIKit
import SnapKit

/*
 1. 객체(클래스의 인스턴스) 추가 (ex. Label, Button 등등)
 2. 객체 배치
 */

class ResultViewController: UIViewController {
    
    let resultLabel = UILabel()
    
    let redView = UIView()
    let blackView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        resultLabel.backgroundColor = .cyan
        
        view.addSubview(resultLabel)
        
        resultLabel.snp.makeConstraints { make in
//            make.leading.trailing.equalTo(view).inset(20)
            make.horizontalEdges.equalTo(view).inset(20)
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.height.equalTo(44)
        }
        
        view.addSubview(redView)
        redView.addSubview(blackView)
        
        redView.snp.makeConstraints { make in
            make.leading.equalTo(view).offset(20)
//            make.width.height.equalTo(100)
            make.size.equalTo(200)
            make.top.equalTo(resultLabel.snp.bottom)
                .offset(20)
        }
        
        redView.backgroundColor = .red
        blackView.backgroundColor = .black
        
        blackView.snp.makeConstraints { make in
//            make.top.equalTo(redView.snp.bottom).offset(20)
////            make.leading.trailing.equalToSuperview().inset(20)
//            make.horizontalEdges.equalToSuperview().inset(20)
//            make.bottom.equalToSuperview().offset(-50)
//            make.top.bottom.leading.trailing.equalToSuperview()
//            make.horizontalEdges.verticalEdges.equalToSuperview()
            make.edges.equalToSuperview().inset(20)
        }
    }
    
    func practiceAutoLayout() {
        resultLabel.translatesAutoresizingMaskIntoConstraints = false
//        let leading = NSLayoutConstraint(item: resultLabel, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 20)
//
//        let trailing = NSLayoutConstraint(item: resultLabel, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: -20)
//
//        let bottom = NSLayoutConstraint(item: resultLabel, attribute: .bottom, relatedBy: .equal, toItem: view.safeAreaLayoutGuide, attribute: .bottom, multiplier: 1, constant: -20)
//
//        let height = NSLayoutConstraint(item: resultLabel, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1, constant: 44)
//
//        view.addConstraints([leading, trailing, bottom, height])
        
        NSLayoutConstraint.activate([
            resultLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            resultLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            resultLabel.heightAnchor.constraint(equalToConstant: 44),
            resultLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    func practiceFrameBasedLayout() {
        view.addSubview(blackView)
        blackView.addSubview(redView)
        
        redView.frame = CGRect(x: 100, y: 150, width: 100, height: 100)
        blackView.frame = CGRect(x: 100, y: 300, width: 200, height: 200)
        
        redView.backgroundColor = .red
        blackView.backgroundColor = .black
        blackView.layer.cornerRadius = 20
        blackView.clipsToBounds = true
        
        // 객체 추가
        view.addSubview(resultLabel)
        
        // 객체 배치
        resultLabel.frame = CGRect(x: 100, y: 100, width: 100, height: 50)
        resultLabel.backgroundColor = .red
        resultLabel.text = "TestLabel"
        resultLabel.textColor = .white
        resultLabel.textAlignment = .center
        
        view.backgroundColor = .cyan
    }
}
