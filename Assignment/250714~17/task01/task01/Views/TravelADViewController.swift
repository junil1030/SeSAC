//
//  TravelADViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class TravelADViewController: UIViewController {
    static let identifier = "TravelADViewController"
    
    @IBOutlet var desLabel: UILabel!
    
    var content: Travel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupContent()
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .close,
            target: self,
            action: #selector(didTapClose)
        )
    }
    
    private func setupUI() {
        navigationItem.title = "광고 화면"
        
        desLabel.textColor = .black
        desLabel.numberOfLines = 0
        desLabel.font = .boldSystemFont(ofSize: 44)
        desLabel.textAlignment = .center
    }

    private func setupContent() {
        guard let content = content else { return }
        desLabel.text = content.title
    }
    
    @objc func didTapClose() {
        dismiss(animated: true)
    }
}
