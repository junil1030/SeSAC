//
//  ChangeNicknameView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/25/25.
//

import UIKit
import SnapKit

final class ChangeNicknameView: BaseView {
    
    private let tabBarLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.buttonTappedColor)
        return label
    }()
    
    private let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요"
        textField.borderStyle = .none
        return textField
    }()
    
    private let textLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.textColor)
        return label
    }()
    
    override func setupHierachy() {
        super.setupHierachy()
        
        addSubview(tabBarLineLabel)
        addSubview(textField)
        addSubview(textLineLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        tabBarLineLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        textField.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(20)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        
        textLineLabel.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom)
            make.horizontalEdges.equalTo(textField)
            make.height.equalTo(1)
        }
    }
    
    func getText() -> String? {
        return textField.text
    }
}
