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
    
    @IBOutlet var riceTextField: UITextField!
    @IBOutlet var waterTextField: UITextField!
    
    @IBOutlet var riceButton: UIButton!
    @IBOutlet var waterButton: UIButton!
    
    var levelManager = Tamagotch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    private func setupUI() {
        riceTextField.borderStyle = .none
        waterTextField.borderStyle = .none
    }
    
    private func refreshData() {
        levelLabel.text = String("LV \(levelManager.getLevel())")
        riceLabel.text = String("밥알 \(levelManager.getRice())개")
        waterLabel.text = String("물방울 \(levelManager.getWater())개")
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
            levelManager.eatRice(eatingRice())
            refreshData()
        } else if sender.tag == 1 {
            levelManager.drinkWater(drinkingWater())
            refreshData()
        } else {
            return
        }
    }
}

