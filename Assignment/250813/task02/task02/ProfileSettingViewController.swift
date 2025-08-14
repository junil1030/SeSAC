//
//  ViewController.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit
import SnapKit

class ProfileSettingViewController: BaseViewController {
    
    // MARK: - UI Components
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = true
        imageView.layer.borderWidth = 3
        imageView.layer.borderColor = UIColor.systemBlue.cgColor
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요 :)"
        textField.borderStyle = .none
        textField.font = .systemFont(ofSize: 14)
        return textField
    }()
    
    private let underlineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.isHidden = true
        return label
    }()
    
    private let mbtiLabel: UILabel = {
        let label = UILabel()
        label.text = "MBTI"
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    // MBTI 커스텀 버튼
    private let eButton = MBTIButton(mbtiType: "E")
    private let iButton = MBTIButton(mbtiType: "I")
    private let sButton = MBTIButton(mbtiType: "S")
    private let nButton = MBTIButton(mbtiType: "N")
    private let tButton = MBTIButton(mbtiType: "T")
    private let fButton = MBTIButton(mbtiType: "F")
    private let jButton = MBTIButton(mbtiType: "J")
    private let pButton = MBTIButton(mbtiType: "P")
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("완료", for: .normal)
        button.backgroundColor = UIColor(hex: "#8C8C8C")
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.layer.cornerRadius = 25
        return button
    }()
    
    // MARK: - Properties
    private var viewModel = ProfileSettingViewModel()
    private var mbtiButtons: [MBTIButton] {
        return [eButton, iButton, sButton, nButton, tButton, fButton, jButton, pButton]
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
    }
    
    // MARK: - Override Methods
    override func setupLayout() {
        super.setupLayout()
        
        view.addSubview(profileImageView)
        view.addSubview(nicknameTextField)
        view.addSubview(underlineView)
        view.addSubview(statusLabel)
        view.addSubview(mbtiLabel)
        view.addSubview(completeButton)
        
        setupConstraints()
    }
    
    override func setupStyle() {
        super.setupStyle()
    }
    
    override func setupDelegate() {
    }
    
    override func setupBind() {
        bindViewModel()
        setupInitialState()
        setupTargets()
    }
    
    // MARK: - Private Methods
    private func setupNavigationBar() {
        title = "PROFILE SETTING"
        
        let backButton = UIBarButtonItem(
            image: UIImage(systemName: "chevron.left"),
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .black
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(40)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(80)
        }
        
        nicknameTextField.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        
        underlineView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(nicknameTextField)
            make.height.equalTo(1)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(nicknameTextField.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(20)
        }
        
        mbtiLabel.snp.makeConstraints { make in
            make.top.equalTo(statusLabel.snp.bottom).offset(40)
            make.leading.equalToSuperview().offset(20)
        }
        
        // MBTI 버튼 4x2
        setupMBTIButtonConstraints()
        
        completeButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-40)
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(50)
        }
    }
    
    private func setupMBTIButtonConstraints() {
        // 첫 번째 가로 스택뷰: E S T J
        let firstRowStackView = UIStackView(arrangedSubviews: [eButton, sButton, tButton, jButton])
        firstRowStackView.axis = .horizontal
        firstRowStackView.distribution = .fillEqually
        firstRowStackView.spacing = 8
        
        // 두 번째 가로 스택뷰: I N F P
        let secondRowStackView = UIStackView(arrangedSubviews: [iButton, nButton, fButton, pButton])
        secondRowStackView.axis = .horizontal
        secondRowStackView.distribution = .fillEqually
        secondRowStackView.spacing = 8
        
        let mbtiStackView = UIStackView(arrangedSubviews: [firstRowStackView, secondRowStackView])
        mbtiStackView.axis = .vertical
        mbtiStackView.distribution = .fillEqually
        mbtiStackView.spacing = 8
        
        view.addSubview(mbtiStackView)
        
        mbtiStackView.snp.makeConstraints { make in
            make.top.equalTo(mbtiLabel)
            make.leading.equalTo(mbtiLabel.snp.trailing).offset(16)
            make.trailing.lessThanOrEqualToSuperview().offset(-20)
        }
    }
    
    private func setupTargets() {
        let profileTapGesture = UITapGestureRecognizer(target: self, action: #selector(profileImageTapped))
        profileImageView.addGestureRecognizer(profileTapGesture)
        
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        
        mbtiButtons.forEach { button in
            button.addTarget(self, action: #selector(mbtiButtonTapped(_:)), for: .touchUpInside)
        }
        
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    private func bindViewModel() {
        viewModel.input.viewDidLoad.value = ()
        
        viewModel.output.profileImage.bind { [weak self] image in
            self?.profileImageView.image = image
        }
        
        viewModel.output.isCompleteButtonEnabled.bind { [weak self] isEnabled in
            self?.updateCompleteButton(isEnabled: isEnabled)
        }
        
        viewModel.output.nicknameStatus.bind { [weak self] status in
            self?.updateNicknameStatus(status)
        }
        
        viewModel.output.mbtiSelection.bind { [weak self] mbti in
            self?.updateMBTIButtons(mbti)
        }
    }
    
    private func setupInitialState() {
        viewModel.input.setRandomProfileImage.value = ()
    }
    
    @objc private func backButtonTapped() {
        viewModel.input.backButtonTapped.value = ()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func profileImageTapped() {
        print("프로필 이미지 탭됨")
    }
    
    @objc private func textFieldDidChange() {
        let text = nicknameTextField.text ?? ""
        viewModel.input.nicknameChanged.value = text
    }
    
    @objc private func mbtiButtonTapped(_ sender: MBTIButton) {
        let selectedMBTI = sender.getMBTIType()
        viewModel.input.mbtiButtonTapped.value = selectedMBTI
    }
    
    @objc private func completeButtonTapped() {
        viewModel.input.completeButtonTapped.value = ()
        
        let mainVC = MainViewController()
        guard let window = view.window else { return }
        window.rootViewController = mainVC
        window.makeKeyAndVisible()
    }
    
    private func updateCompleteButton(isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
        completeButton.backgroundColor = isEnabled ? UIColor(hex: "#186FF2") : UIColor(hex: "#8C8C8C")
    }
    
    private func updateNicknameStatus(_ status: NicknameStatus) {
        switch status {
        case .empty:
            statusLabel.isHidden = true
        case .valid:
            statusLabel.isHidden = false
            statusLabel.text = "사용할 수 있는 닉네임이에요"
            statusLabel.textColor = UIColor(hex: "#186FF2")
        case .tooShort, .tooLong:
            statusLabel.isHidden = false
            statusLabel.text = "2글자 이상 10글자 미만으로 설정해주세요"
            statusLabel.textColor = UIColor(hex: "#F04452")
        case .containsSpecialChar:
            statusLabel.isHidden = false
            statusLabel.text = "닉네임에 @, #, $, % 는 포함할 수 없어요"
            statusLabel.textColor = UIColor(hex: "#F04452")
        case .containsNumber:
            statusLabel.isHidden = false
            statusLabel.text = "닉네임에 숫자는 포함할 수 없어요"
            statusLabel.textColor = UIColor(hex: "#F04452")
        }
    }
    
    private func updateMBTIButtons(_ mbti: MBTI) {
        mbtiButtons.forEach { button in
            let mbtiType = button.getMBTIType()
            button.isSelected = mbti.contains(mbtiType)
        }
    }
}
