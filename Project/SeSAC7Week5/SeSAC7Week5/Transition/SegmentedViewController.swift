//
//  SegmentedViewController.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 8/1/25.
//

import UIKit
import SnapKit

enum Student: Int { // 멤버
    case elementary
    case middle
    case high
    case university
    
    var introduce: String {
        switch self {
        case .elementary:
            return "잼미니"
        case .middle:
            return "급식충"
        case .high:
            return "ㅈ고딩"
        case .university:
            return "학식충"
        }
    }
}

class SegmentedViewController: UIViewController {
    
    private let segmentedControl = UISegmentedControl()
    private let resultLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        
        print(Student.elementary)
        print(Student.elementary.rawValue)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
         
        segmentedControl.insertSegment(withTitle: "초등학생", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "중학생", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "고등학생", at: 2, animated: false)
        segmentedControl.insertSegment(withTitle: "대학생", at: 3, animated: false)
        
        // 첫 번째 세그먼트를 기본 선택
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.backgroundColor = .systemGray6
        segmentedControl.selectedSegmentTintColor = .systemBlue
        
        // 레이블 설정
        resultLabel.text = "초등학생입니다"
        resultLabel.font = UIFont.systemFont(ofSize: 24, weight: .medium)
        resultLabel.textAlignment = .center
        resultLabel.textColor = .label
        resultLabel.backgroundColor = .systemGray6
        resultLabel.layer.cornerRadius = 12
        resultLabel.clipsToBounds = true
        
        // 뷰에 추가
        view.addSubview(segmentedControl)
        view.addSubview(resultLabel)
    }
    
    private func setupConstraints() {
        // 세그먼트 컨트롤
        segmentedControl.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(50)
        }
        
        // 결과 레이블
        resultLabel.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom).offset(80)
            make.leading.trailing.equalToSuperview().inset(30)
            make.height.equalTo(100)
        }
    }
    
    private func setupActions() {
        segmentedControl.addTarget(self, action: #selector(segmentChanged), for: .valueChanged)
    }
    
    @objc private func segmentChanged() {
        let index = segmentedControl.selectedSegmentIndex
        
        let result = Student(rawValue: index) ?? .university
        
        resultLabel.text = result.introduce
    }
}
