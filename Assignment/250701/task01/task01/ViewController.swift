//
//  ViewController.swift
//  task01
//
//  Created by 서준일 on 7/1/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var happyButton: UIButton!
    @IBOutlet var loveButton: UIButton!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var embarrasButton: UIButton!
    @IBOutlet var upsetButton: UIButton!
    @IBOutlet var depressedButton: UIButton!
    @IBOutlet var boredButton: UIButton!
    @IBOutlet var sadButton: UIButton!
    @IBOutlet var shameButton: UIButton!
    
    @IBOutlet var happyLabel: UILabel!
    @IBOutlet var loveLabel: UILabel!
    @IBOutlet var likeLabel: UILabel!
    @IBOutlet var embarrasLabel: UILabel!
    @IBOutlet var upsetLabel: UILabel!
    @IBOutlet var depressedLabel: UILabel!
    @IBOutlet var boredLabel: UILabel!
    @IBOutlet var sadLabel: UILabel!
    @IBOutlet var shameLabel: UILabel!
    
    var emotionDict: [String: Int] = [
        "happy": 0, "love": 0, "like":0,
        "embarras": 0, "upset": 0, "depressed": 0,
        "bored": 0, "sad": 0, "shame": 0
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupButton()
        setupLabel()
    }

    func setupButton() {
        happyButton.setImage(UIImage(named: "mono_slime1")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        happyButton.setTitle("", for: .normal)
        
        loveButton.setImage(UIImage(named: "mono_slime2")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        loveButton.setTitle("", for: .normal)
        
        likeButton.setImage(UIImage(named: "mono_slime3")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        likeButton.setTitle("", for: .normal)
        
        embarrasButton.setImage(UIImage(named: "mono_slime4")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        embarrasButton.setTitle("", for: .normal)
        
        upsetButton.setImage(UIImage(named: "mono_slime5")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        upsetButton.setTitle("", for: .normal)
        
        depressedButton.setImage(UIImage(named: "mono_slime6")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        depressedButton.setTitle("", for: .normal)
        
        boredButton.setImage(UIImage(named: "mono_slime7")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        boredButton.setTitle("", for: .normal)
        
        sadButton.setImage(UIImage(named: "mono_slime8")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        sadButton.setTitle("", for: .normal)
        
        shameButton.setImage(UIImage(named: "mono_slime9")?.resizing(size: CGSize(width: 100, height: 80)), for: .normal)
        shameButton.setTitle("", for: .normal)
    }
    
    func setupLabel() {
        happyLabel.text = "행복해 0"
        loveLabel.text = "사랑해 0"
        likeLabel.text = "좋아해 0"
        embarrasLabel.text = "당황해 0"
        upsetLabel.text = "속상해 0"
        depressedLabel.text = "우울해 0"
        boredLabel.text = "심심해 0"
        sadLabel.text = "눈물나 0"
        shameLabel.text = "부끄러 0"
    }
    
    @IBAction func emotionButtonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            emotionDict["happy"]! += 1
            happyLabel.text = "행복해 \(emotionDict["happy"]!)"
            print(emotionDict["happy"]!)
        case 1:
            emotionDict["love"]! += 1
            loveLabel.text = "사랑해 \(emotionDict["love"]!)"
            print(emotionDict["love"]!)
        case 2:
            emotionDict["like"]! += 1
            likeLabel.text = "좋아해 \(emotionDict["like"]!)"
            print(emotionDict["like"]!)
        case 3:
            emotionDict["embarras"]! += 1
            embarrasLabel.text = "당황해 \(emotionDict["embarras"]!)"
            print(emotionDict["embarras"]!)
        case 4:
            emotionDict["upset"]! += 1
            upsetLabel.text = "속상해 \(emotionDict["upset"]!)"
            print(emotionDict["upset"]!)
        case 5:
            emotionDict["depressed"]! += 1
            depressedLabel.text = "우울해 \(emotionDict["depressed"]!)"
            print(emotionDict["depressed"]!)
        case 6:
            emotionDict["bored"]! += 1
            boredLabel.text = "심심해 \(emotionDict["bored"]!)"
            print(emotionDict["bored"]!)
        case 7:
            emotionDict["sad"]! += 1
            sadLabel.text = "눈물나 \(emotionDict["sad"]!)"
            print(emotionDict["sad"]!)
        case 8:
            emotionDict["shame"]! += 1
            shameLabel.text = "부끄러 \(emotionDict["shame"]!)"
            print(emotionDict["shame"]!)
        default:
            break
        }
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
