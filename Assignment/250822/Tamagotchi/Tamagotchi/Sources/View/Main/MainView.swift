//
//  MainView.swift
//  Tamagotchi
//
//  Created by 서준일 on 8/23/25.
//

import UIKit
import SnapKit

final class MainView: BaseView {
    
    var onMealButtonTapped: ((String?) -> Void)?
    var onDropButtonTapped: ((String?) -> Void)?
    
    private let tabBarLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.buttonTappedColor)
        return label
    }()
    
    private let totalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let messageView = UIView()
    private let bubbleImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: Image.bubbleImage)
        return imageView
    }()
    
    private let messageLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "asdfasdfasdfasdfsadf"
        label.numberOfLines = 3
        label.textAlignment = .center
        return label
    }()
    
    private let tamagotchiImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "2-9")
        return imageView
    }()
    
    private let titleContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(named: ColorName.backgroundColor)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(named: ColorName.textColor)?.cgColor
        view.layer.cornerRadius = 6
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "방실방실 다마고치"
        label.font = .systemFont(ofSize: 14)
        label.textColor = UIColor(named: ColorName.textColor)
        label.textAlignment = .center
        return label
    }()
    
    private let statStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 4
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let lvLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "LV0"
        return label
    }()
    
    private let mealLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "밥알 00개"
        return label
    }()
    
    private let dropLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "물방울 00개"
        return label
    }()
    
    private let separteLabel1: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "・"
        return label
    }()
    
    private let separteLabel2: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(named: ColorName.textColor)
        label.text = "・"
        return label
    }()
    
    private let mealViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let inputMealStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let inputMealField: UITextField = {
        let inputField = UITextField()
        inputField.borderStyle = .none
        inputField.textColor = UIColor(named: ColorName.textColor)
        inputField.textAlignment = .center
        inputField.placeholder = "밥주세용"
        return inputField
    }()
    
    private let inputMealLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.textColor)
        return label
    }()
    
    private let mealButton = CustomButton(type: .leaf, text: "밥먹기")
    
    private let dropViewStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .horizontal
        return stackView
    }()
    
    private let inputDropStack: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 0
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        return stackView
    }()
    
    private let inputDropField: UITextField = {
        let inputField = UITextField()
        inputField.borderStyle = .none
        inputField.textColor = UIColor(named: ColorName.textColor)
        inputField.textAlignment = .center
        inputField.placeholder = "물주세용"
        return inputField
    }()
    
    private let inputDropLineLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor(named: ColorName.textColor)
        return label
    }()
    
    private let dropButton = CustomButton(type: .drop, text: "물먹기")
    
    override func setupHierachy() {
        super.setupHierachy()
        
        // 탭바 라인
        addSubview(tabBarLineLabel)
        
        // 전체 스택
        addSubview(totalStackView)
        
        // 메세지 뷰
        totalStackView.addArrangedSubview(messageView)
        messageView.addSubview(bubbleImageView)
        messageView.addSubview(messageLabel)
        
        // 타마고치 이미지
        totalStackView.addArrangedSubview(tamagotchiImage)
        
        // 다마고치 타이틀
        totalStackView.addArrangedSubview(titleContainerView)
        titleContainerView.addSubview(titleLabel)
        
        // 스탯창
        totalStackView.addArrangedSubview(statStackView)
        statStackView.addArrangedSubview(lvLabel)
        statStackView.addArrangedSubview(separteLabel1)
        statStackView.addArrangedSubview(mealLabel)
        statStackView.addArrangedSubview(separteLabel2)
        statStackView.addArrangedSubview(dropLabel)
        
        // 밥먹기 뷰
        totalStackView.addArrangedSubview(mealViewStack)
        mealViewStack.addArrangedSubview(inputMealStack)
        mealViewStack.addArrangedSubview(mealButton)
        inputMealStack.addArrangedSubview(inputMealField)
        inputMealStack.addArrangedSubview(inputMealLineLabel)
        
        // 물먹기 뷰
        totalStackView.addArrangedSubview(dropViewStack)
        dropViewStack.addArrangedSubview(inputDropStack)
        dropViewStack.addArrangedSubview(dropButton)
        inputDropStack.addArrangedSubview(inputDropField)
        inputDropStack.addArrangedSubview(inputDropLineLabel)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        // 탭바 라인
        tabBarLineLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        // 전체 스택뷰 - 화면 중앙에 배치, 세로 공간의 80% 사용
        totalStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.lessThanOrEqualToSuperview().multipliedBy(0.8)
            make.width.equalToSuperview().multipliedBy(0.6)
        }
        
        // 메시지 뷰 - 전체 높이의 15% 정도
        messageView.snp.makeConstraints { make in
            make.width.equalTo(totalStackView)
            make.height.equalTo(totalStackView).multipliedBy(0.25)
        }
        
        // 말풍선 이미지뷰
        bubbleImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        // 메시지 라벨 - 말풍선 내부에 배치
        messageLabel.snp.makeConstraints { make in
//            make.centerX.equalToSuperview()
//            make.centerY.equalToSuperview().offset(-5)
            make.edges.equalToSuperview().inset(5)
        }
        
        // 다마고치 이미지
        tamagotchiImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(tamagotchiImage.snp.width)
        }
        
        // 타이틀 컨테이너 뷰
        titleContainerView.snp.makeConstraints { make in
            make.height.equalTo(32)
        }
        
        // 타이틀 라벨
        titleLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(5)
        }
        
        // 스탯 스택뷰
        statStackView.snp.makeConstraints { make in
            make.height.equalTo(20)
        }
        
        // 밥먹기 뷰 스택
        mealViewStack.snp.makeConstraints { make in
            make.width.equalTo(totalStackView)
            make.height.equalTo(44)
        }
        
        // 밥 입력 스택
        inputMealStack.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.65)
        }
        
        // 밥 입력 필드
        inputMealField.snp.makeConstraints { make in
            make.height.equalTo(43)
        }
        
        // 밥 입력 라인
        inputMealLineLabel.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(inputMealStack)
        }
        
        // 밥먹기 버튼
        mealButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
        }
        
        // 물먹기 뷰 스택
        dropViewStack.snp.makeConstraints { make in
            make.width.equalTo(totalStackView)
            make.height.equalTo(44)
        }
        
        // 물 입력 스택
        inputDropStack.snp.makeConstraints { make in
            make.width.lessThanOrEqualToSuperview().multipliedBy(0.65)
        }
        
        // 물 입력 필드
        inputDropField.snp.makeConstraints { make in
            make.height.equalTo(43)
        }
        
        // 물 입력 라인
        inputDropLineLabel.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(inputDropStack)
        }
        
        // 물먹기 버튼
        dropButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.35)
        }
    }
    
    override func setupStyle() {
        super.setupStyle()
        
        setupButtonActions()
    }
    
    private func setupButtonActions() {
        mealButton.addTarget(self, action: #selector(mealButtonTapped), for: .touchUpInside)
        dropButton.addTarget(self, action: #selector(dropButtonTapped), for: .touchUpInside)
    }
    
    @objc private func mealButtonTapped() {
        onMealButtonTapped?(inputMealField.text)
    }
    
    @objc private func dropButtonTapped() {
        onDropButtonTapped?(inputDropField.text)
    }
    
    func configure(tamagotchi: TamagotchiItem, stats: TamagotchiStats, message: String, imageText: String) {
        tamagotchiImage.image = UIImage(named: imageText)
        titleLabel.text = tamagotchi.title
        lvLabel.text = "LV\(stats.level)"
        mealLabel.text = "밥알 \(stats.mealCount)개"
        dropLabel.text = "물방울 \(stats.waterCount)개"
        messageLabel.text = message
    }
}
