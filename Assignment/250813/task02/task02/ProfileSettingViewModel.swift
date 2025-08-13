//
//  ProfileSettingViewModel.swift
//  task02
//
//  Created by 서준일 on 8/13/25.
//

import UIKit

class ProfileSettingViewModel {
    
    struct Input {
        let viewDidLoad = Observable<Void>(())
        let nicknameChanged = Observable<String>("")
        let mbtiButtonTapped = Observable<String>("")
        let profileImageSelected = Observable<UIImage?>(nil)
        let setRandomProfileImage = Observable<Void>(())
        let completeButtonTapped = Observable<Void>(())
        let backButtonTapped = Observable<Void>(())
    }
    
    struct Output {
        let profileImage = Observable<UIImage?>(nil)
        let nicknameStatus = Observable<NicknameStatus>(.empty)
        let mbtiSelection = Observable<MBTI>(MBTI())
        let isCompleteButtonEnabled = Observable<Bool>(false)
    }
    
    let input = Input()
    let output = Output()
    
    private var currentNickname = ""
    private var currentMBTI = MBTI()
    private var currentProfileImage: UIImage?
    
    init() {
        bindInput()
    }
    
    private func bindInput() {
        input.viewDidLoad.lazyBind { [weak self] _ in
            self?.setupInitialState()
        }
        
        input.nicknameChanged.lazyBind { [weak self] nickname in
            self?.handleNicknameChange(nickname)
        }
        
        input.mbtiButtonTapped.lazyBind { [weak self] mbtiType in
            self?.handleMBTISelection(mbtiType)
        }
        
        input.profileImageSelected.lazyBind { [weak self] image in
            if let image = image {
                self?.handleProfileImageSelection(image)
            }
        }
        
        input.setRandomProfileImage.lazyBind { [weak self] _ in
            self?.setRandomProfileImage()
        }
        
        input.backButtonTapped.lazyBind { [weak self] _ in
            self?.resetAllData()
        }
    }
    
    private func setupInitialState() {
        checkCompleteButtonState()
    }
    
    private func handleNicknameChange(_ nickname: String) {
        currentNickname = nickname
        let status = validateNickname(nickname)
        output.nicknameStatus.value = status
        checkCompleteButtonState()
    }
    
    private func handleMBTISelection(_ mbtiType: String) {
        currentMBTI.toggle(mbtiType)
        output.mbtiSelection.value = currentMBTI
        checkCompleteButtonState()
    }
    
    private func handleProfileImageSelection(_ image: UIImage) {
        currentProfileImage = image
        output.profileImage.value = image
    }
    
    private func setRandomProfileImage() {
        let systemImages = ["person.fill", "person.circle.fill", "person.crop.circle.fill", "person.and.background.dotted"]
        let randomIndex = Int.random(in: 0..<systemImages.count)
        let randomImage = UIImage(systemName: systemImages[randomIndex]) ?? UIImage()
        
        currentProfileImage = randomImage
        output.profileImage.value = randomImage
    }
    
    private func resetAllData() {
        currentNickname = ""
        currentMBTI = MBTI()
        currentProfileImage = nil
        
        output.nicknameStatus.value = .empty
        output.mbtiSelection.value = MBTI()
        output.isCompleteButtonEnabled.value = false
        setRandomProfileImage()
    }
    
    private func validateNickname(_ nickname: String) -> NicknameStatus {
        if nickname.isEmpty {
            return .empty
        }
        
        if nickname.count < 2 {
            return .tooShort
        }
        
        if nickname.count >= 10 {
            return .tooLong
        }
        
        let specialChars = ["@", "#", "$", "%"]
        for char in specialChars {
            if nickname.contains(char) {
                return .containsSpecialChar
            }
        }
        
        if nickname.rangeOfCharacter(from: .decimalDigits) != nil {
            return .containsNumber
        }
        
        return .valid
    }
    
    private func checkCompleteButtonState() {
        let isNicknameValid = validateNickname(currentNickname) == .valid
        let isMBTIComplete = currentMBTI.isComplete()
        
        let isEnabled = isNicknameValid && isMBTIComplete
        output.isCompleteButtonEnabled.value = isEnabled
    }
}
