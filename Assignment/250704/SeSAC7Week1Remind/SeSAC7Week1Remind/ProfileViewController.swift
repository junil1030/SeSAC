//
//  ProfileViewController.swift
//  SeSAC7Week1Remind
//
//  Created by 서준일 on 7/5/25.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var profileMusicView: UIView!
    @IBOutlet var profileMusicImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        setupUI()
    }
    
    private func setupUI() {
        profileImage.layer.cornerRadius = profileImage.frame.width / 3
        profileMusicView.layer.cornerRadius = profileMusicView.frame.width / 8
        profileMusicImage.layer.cornerRadius = profileMusicImage.frame.width / 3
    }

}
