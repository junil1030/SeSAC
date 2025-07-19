//
//  CityDetailViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class CityDetailViewController: UIViewController {
    static let identifier = "CityDetailViewController"

    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var cityEnglishNameLabel: UILabel!
    
    var city: City?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "세부 내용"
        setupUI()
    }
    
    private func setupUI() {
        setupImageView()
        setupLabel()
        setupContent()
    }
    
    private func setupImageView() {
        cityImageView.layer.cornerRadius = 16
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
    }
    
    private func setupLabel() {
        cityNameLabel.textColor = .black
        cityNameLabel.textAlignment = .center
        cityNameLabel.font = .boldSystemFont(ofSize: 22)
        
        cityEnglishNameLabel.textColor = .black
        cityEnglishNameLabel.textAlignment = .center
        cityEnglishNameLabel.font = .boldSystemFont(ofSize: 18)
    }
    
    func setupContent() {
        guard let city = city else { return }
        cityImageView.setImage(with: city.city_image)
        cityNameLabel.text = city.city_name
        cityEnglishNameLabel.text = city.city_english_name
    }
}
