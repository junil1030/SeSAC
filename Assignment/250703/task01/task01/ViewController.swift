//
//  ViewController.swift
//  task01
//
//  Created by 서준일 on 7/3/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet var resultLabel: UILabel!
    
    @IBOutlet var keywordButtons: [UIButton]!
    
    // 이게 변수임
    private let slangManager = SlangWords()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        recommendKeyword()
        setupUI()
    }

    func setupUI() {
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.layer.borderWidth = 5
        
        searchButton.setTitle("", for: .normal)
        searchButton.backgroundColor = .black
        searchButton.setImage(UIImage(systemName: "magnifyingglass")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        
        backgroundImage.image = UIImage(named: "word_logo")!
        resultLabel.font = .systemFont(ofSize: 13, weight: .bold)
        resultLabel.text = ""
        resultLabel.textAlignment = .center
        
        for button in keywordButtons {
            button.layer.cornerRadius = 5
            button.layer.borderColor = UIColor.black.cgColor
            button.layer.borderWidth = 3
            button.setTitleColor(.black, for: .normal)
            button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
            button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 10, bottom: 8, right: 10)
            button.sizeToFit()
        }
    }
    
    @IBAction func searchButtonClicked(_ sender: UIButton) {
        view.endEditing(true)
        backgroundImage.image = UIImage(named: "background")
        
        guard let keyword = searchTextField.text else { return }
        
        resultLabel.text = searchSlangWord(keyword)
        recommendKeyword()
    }
    
    @IBAction func searchTextFieldDidEnd(_ sender: UITextField) {
        backgroundImage.image = UIImage(named: "background")
        
        guard let keyword = searchTextField.text else { return }
        
        resultLabel.text = searchSlangWord(keyword)
        recommendKeyword()
    }
    @IBAction func recommendKeywordButtonClicked(_ sender: UIButton) {
        guard let keyword = sender.currentTitle else { return }
        
        searchTextField.text = keyword
        searchButtonClicked(searchButton)
    }
    
    @IBAction func dismissKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    private func recommendKeyword() {
        let keywords = slangManager.getRandomKeywords(count: 4)
        
        for (index, keyword) in keywords.enumerated() {
            keywordButtons[index].setTitle(keyword, for: .normal)
        }
    }
    
    private func searchSlangWord(_ keyword: String) -> String {
        if let result = slangManager.searchWord(keyword) {
            return result
        } else {
            return "검색 결과가 없습니다."
        }
    }
}

