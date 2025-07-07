//
//  EmotionViewController.swift
//  task01
//
//  Created by 서준일 on 7/2/25.
//

import UIKit

enum Emotion: String, CaseIterable {
    case happy = "행복해"
    case love = "사랑해"
    case like = "좋아해"
    case embarras = "당황해"
    case upset = "속상해"
    case depressed = "우울해"
    case bored = "심심해"
    case sad = "눈물나"
    case shame = "부끄러"
}

class EmotionViewController: UIViewController {

    @IBOutlet var emotionButton: [UIButton]!
    @IBOutlet var emotionLabel: [UILabel]!
    
    var emotionDict: [Emotion: Int] = [
        .happy: 0, .love: 0, .like: 0,
        .embarras: 0, .upset: 0, .depressed: 0,
        .bored: 0, .sad: 0, .shame: 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupButton()
        setupLabel()
    }
    
    func setupButton() {
        for i in 0..<emotionButton.count {
            let imageName = "mono_slime\(i+1)"
            emotionButton[i].setImage(UIImage(named: imageName)?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
            emotionButton[i].setTitle("", for: .normal)
        }
    }
    
    func setupLabel() {
        let emotion = Emotion.allCases
        for i in 0..<emotionLabel.count {
            emotionLabel[i].text = "\(emotion[i].rawValue) \(emotionDict[emotion[i]]!)"
        }
    }

    @IBAction func emotionButtonClicked(_ sender: UIButton) {
        guard let index = emotionButton.firstIndex(of: sender) else { return }
        
        let emotion = Emotion.allCases[index]
        emotionDict[emotion]! += 1
        emotionLabel[index].text = "\(emotion.rawValue) \(emotionDict[emotion]!)"
    }
    
}

extension UIImage {
    func resizing(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        guard let resizedImage = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
