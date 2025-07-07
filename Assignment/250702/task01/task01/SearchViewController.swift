//
//  SearchViewController.swift
//  task01
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet var filterButton: [UIButton]!
    
    @IBOutlet var mainLabel: UILabel!
    @IBOutlet var subLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
    }
    
    func setupButton() {
        for button in filterButton {
            button.layer.cornerRadius = 15
        }
    }
    
    
    @IBAction func filterButtonClicked(_ sender: UIButton) {
        for button in filterButton {
            button.backgroundColor = .clear
            button.setTitleColor(.white, for: .normal)
        }
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
        
        if let index = filterButton.firstIndex(of: sender) {
            switch index {
            case 0:
                mainLabel.text = "공개 예정인 작품이 없습니다!"
                subLabel.text = "기대해주세요.."
            case 1:
                mainLabel.text = "이런! 찾으시는 작품이 없습니다."
                subLabel.text = "다른 영화, 시리즈, 배우, 감독 또는 장르를 검색해 보세요."
            case 2:
                mainLabel.text = "Top10시리즈 입니다."
                subLabel.text = "인기많은 건 이유가 있죠"
            default:
                break
            }
        }
    }
}
