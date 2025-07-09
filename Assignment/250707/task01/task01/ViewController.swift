//
//  ViewController.swift
//  task01
//
//  Created by 서준일 on 7/7/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var levelLabel: UILabel!
    @IBOutlet var riceLabel: UILabel!
    @IBOutlet var waterLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    @IBOutlet var tamagotchImage: UIImageView!
    @IBOutlet var tamagotchNameView: UIView!
    
    @IBOutlet var resetButton: UIButton!
    
    var tamagotch = TamagotchManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        setupData()
    }
    
    private func setupData() {
        let nickName = tamagotch.nickName
        navigationItem.title = "\(nickName)님의 다마고치"
        messageLabel.text = tamagotch.randomMessage(for: nickName)
        refreshData()
    }

    private func setupUI() {
        let appearance = UINavigationBarAppearance()
        appearance.titleTextAttributes = [
            .foregroundColor: Constants.baseColor
        ]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = Constants.baseColor
        // 스크롤이 필요한 경우에는
        // navigationController?.navigationBar.scrollEdgeAppearance = appearance
        riceTextField.borderStyle = .none
        waterTextField.borderStyle = .none
        
        tamagotchNameView.layer.borderColor = Constants.baseColor.cgColor
        tamagotchNameView.layer.borderWidth = 1
        tamagotchNameView.layer.cornerRadius = 5
        
        riceButton.layer.borderColor = Constants.baseColor.cgColor
        riceButton.layer.cornerRadius = 10
        riceButton.layer.borderWidth = 1
        riceButton.layer.masksToBounds = true
        
        waterButton.layer.borderColor = Constants.baseColor.cgColor
        waterButton.layer.cornerRadius = 10
        waterButton.layer.borderWidth = 1
        waterButton.layer.masksToBounds = true
        
        resetButton.setTitle("초기화 하기", for: .normal)
        resetButton.tintColor = .red
        resetButton.titleLabel?.font = .systemFont(ofSize: 12)
    }
    
    
    private func refreshData() {
        // C Style의 포맷 방식은 정밀성을 요구할 때 사용된다.
        // 예를 들어 지역화와 소수점
        let number = 1234.561234

        // 미국 지역 (en_US) → 소수점 기호는 .
        let usFormat = String(format: "%.2f", locale: Locale(identifier: "en_US"), number)
        print(usFormat)  // "1234.56"

        // 독일 지역 (de_DE) → 소수점 기호는 ,
        let deFormat = String(format: "%.2f", locale: Locale(identifier: "de_DE"), number)
        print(deFormat)  // "1234,56"
        
        levelLabel.text = String("LV \(tamagotch.level)") // string interpolation과 무슨 차이가 있을까?
        riceLabel.text = String("밥알 \(tamagotch.rice)개")
        waterLabel.text = String("물방울 \(tamagotch.water)개")
        tamagotchImage.image = UIImage(named: tamagotch.imageText)
    }
    
    private func eatingRice() -> Int {
        guard let riceText = riceTextField.text else { return 0 }
        
        if riceText == "" { return 1 }
        
        guard let rice = Int(riceText), rice > 0, rice < 100 else { return 0 }
        
        return rice
    }
    
    private func drinkingWater() -> Int {
        guard let waterText = waterTextField.text else { return 0 }
        
        if waterText == "" { return 1 }
    
        guard let water = Int(waterText), water > 0, water < 50 else { return 0 }
        
        return water
    }
    
    @IBAction func addButtonTapped(_ sender: UIButton) {
        if sender.tag == 0 {
            tamagotch.eatRice(eatingRice())
            refreshData()
        } else if sender.tag == 1 {
            tamagotch.drinkWater(drinkingWater())
            refreshData()
        } else {
            return
        }
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "경고", message: "정말 초기화 하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default) { _ in
            self.tamagotch.resetTamagotch()
            self.refreshData()
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        present(alert, animated: true)
    }
}

