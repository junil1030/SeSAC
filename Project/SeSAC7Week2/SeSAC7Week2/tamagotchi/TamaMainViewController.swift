//
//  TamaMainViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/9/25.
//

import UIKit

class TamaMainViewController: UIViewController {
    
    let random: [UIColor] = [.red, .orange, .yellow, .green, .blue, .systemBlue, .purple]

    override func viewDidLoad() {
        super.viewDidLoad()
        print(#function)
        
        configureNavigationItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print(#function)
        
        // view.backgroundColor = random.randomElement()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print(#function)
        
    }
    
    func configureNavigationItem() {
        let a = getRandomNickname()
        navigationItem.title = "\(a)님의 다마고치"
    }
    
    func getRandomNickname() -> String {
        let nick = ["a", "b", "c", "d", "e"]
        let random = nick.randomElement() ?? "대장"
    
        return random
    }
    
    // 직접 작성한 코드 (컨트롤 드래그 한 거 아님)
    @IBAction func unwindToMainVC(_ segue: UIStoryboardSegue) {
        print("TamaMainViewController로 왔습니다")
    }
}
