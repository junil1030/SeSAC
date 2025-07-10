//
//  DramaTableViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class DramaTableViewController: UITableViewController {
    
    let image = ["star.fill", "star", "heart", "heart.fill", "pencil", "xmark", "person"]

    var nickName: String? = "고래밥"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Optional >> ?, ??, ?, 옵셔널 바인딩(if let / guard)
        
        if let name = nickName {
            print(name)
        }
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return image.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dramaCell", for: indexPath) as! DramaTableViewCell
        
        cell.overviewLabel.numberOfLines = 0
        cell.overviewLabel.text = "asdasdfasdglaijczvlbk;jdsfoigjsdflkgvjcivkmjanSDOIjghyioregjvfx;kclvzjxlkcvjdsoia;gfjilxfcjvcibohjfduighw2jk3lhrqiuwehiuhxcfvkjzlhdv"
        cell.posterIamgeView.backgroundColor = .orange
        cell.posterIamgeView.layer.cornerRadius = 10
        
        let name = image[indexPath.row]
        cell.posterIamgeView.image = UIImage(systemName: name)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

}
