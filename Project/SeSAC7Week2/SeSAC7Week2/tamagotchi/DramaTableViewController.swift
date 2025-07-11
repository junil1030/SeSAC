//
//  DramaTableViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class DramaTableViewController: UITableViewController {
    
    let image = ["star.fill", "star", "heart", "heart.fill", "pencil", "xmark", "person"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source
    
    // Header, Footer 설정 시에는
    // titleForHeaderInSection의 사용보다는 viewForHeaderInSection으로 설정하는 것이 더 좋다.
    // 건드릴 수 있는 옵션이 많기 때문 titleForHeaderInSection은 오직 텍스트만 return
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerFooterView = UITableViewHeaderFooterView()
        
        var configuration = headerFooterView.defaultContentConfiguration()
        configuration.text = "Test Text"
        configuration.textProperties.color = .red
        
        headerFooterView.contentConfiguration = configuration
        
        return headerFooterView
    }

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
