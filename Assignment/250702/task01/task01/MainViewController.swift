//
//  ViewController.swift
//  task01
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet var playButton: UIButton!
    @IBOutlet var listButton: UIButton!
    
    @IBOutlet var recommendImageView: [UIImageView]!
    @IBOutlet var top10BadgeImageView: [UIImageView]!
    @IBOutlet var netflixBadgeImageView: [UIImageView]!
    @IBOutlet var bannerLabel: [UILabel]!
    
    let imageManager = ImageData()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        designImageView()
    }

    func designImageView() {
        
        for imageView in recommendImageView {
            imageView.layer.cornerRadius = 10
            imageView.layer.borderWidth = 5
            imageView.layer.borderColor = UIColor.clear.cgColor
        }

    }
    
    @IBAction func playButtonClicked(_ sender: UIButton) {
        print(#function)
        
        // 이미지 랜덤하게
        for imageView in recommendImageView {
            imageView.image = imageManager.getimage()
        }
        
        // top10 랜덤
        for imageView in top10BadgeImageView {
            imageView.isHidden = Bool.random()
        }
        
        // netflix 뱃지 랜덤
        for imageView in netflixBadgeImageView {
            imageView.isHidden = Bool.random()
        }
        
        // banner 랜덤
        for i in stride(from: 0, to: bannerLabel.count, by: 3) {
            let isEpisodeVisible = Bool.random()
            let isSeries = !isEpisodeVisible
            let isVisible = Bool.random()
            
            bannerLabel[i].isHidden = isEpisodeVisible
            bannerLabel[i+1].isHidden = isVisible
            bannerLabel[i+2].isHidden = isSeries
            
        }
    }
    
}

