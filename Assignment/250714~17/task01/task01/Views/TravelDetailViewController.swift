//
//  CityDetailViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class TravelDetailViewController: UIViewController {
    static let identifier = "TravelDetailViewController"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var desLabel: UILabel!
    @IBOutlet var popButton: UIButton!

    var content: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "관광지 화면"
        setupUI()
    }
    
    private func setupUI() {
        setupImageView()
        setupLabel()
        setupButton()
        setupContent()
    }
    
    private func setupImageView() {
        cityImageView.layer.cornerRadius = 8
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
    }
    
    private func setupLabel() {
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        titleLabel.font = .boldSystemFont(ofSize: 22)
        
        desLabel.textColor = .black
        desLabel.textAlignment = .center
        desLabel.font = .boldSystemFont(ofSize: 18)
        desLabel.numberOfLines = 0
    }
    
    private func setupButton() {
        popButton.setTitleColor(.white, for: .normal)
        popButton.setTitle("다른 관광지 보러가기", for: .normal)
        popButton.backgroundColor = CustomColor.buttonBackgroundColor
        popButton.layer.cornerRadius = popButton.frame.height / 2
        popButton.clipsToBounds = true
    }
    
    private func setupContent() {
        guard let content = content else { return }
        
        titleLabel.text = content.title
        desLabel.text = content.description
        cityImageView.setImage(with: content.travel_image)
    }
}
