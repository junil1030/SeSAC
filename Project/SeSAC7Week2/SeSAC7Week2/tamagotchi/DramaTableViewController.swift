//
//  DramaTableViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/10/25.
//

import UIKit
import Kingfisher

struct Drama {
    let title: String
    let date: String
    let rate: Double
    let image: String
}

class DramaTableViewController: UITableViewController {
    
    let image = [
        Drama(title: "0", date: "250302", rate: 3.4, image: "star.fill"),
        Drama(title: "1", date: "200330", rate: 2.8, image: "star.fill"),
        Drama(title: "2", date: "190719", rate: 4.2, image: "star.fill"),
        Drama(title: "3", date: "200103", rate: 5.0, image: "star.fill"),
        Drama(title: "4", date: "020804", rate: 2.6, image: "star.fill")
    ]
    
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
        print(#function, indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "dramaCell", for: indexPath) as! DramaTableViewCell
        
        cell.overviewLabel.numberOfLines = 0
        cell.overviewLabel.text = "asdasdfasdglaijczvlbk;jdsfoigjsdflkgvjcivkmjanSDOIjghyioregjvfx;kclvzjxlkcvjdsoia;gfjilxfcjvcibohjfduighw2jk3lhrqiuwehiuhxcfvkjzlhdv"
        cell.posterIamgeView.backgroundColor = .orange
        cell.posterIamgeView.layer.cornerRadius = 10
        
        // https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFUAfyVe3Easiycyh3isP9wDQTYuSmGPsPQvLIJdEYvQ_DsFq5Ez2Nh_QjiS3oZ3B8ZPfK9cZQyIStmQMV1lDPLw
        
        let name = image[indexPath.row].image
        cell.posterIamgeView.image = UIImage(systemName: name)
        
//        let url = URL(string:
//                        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSFUAfyVe3Easiycyh3isP9wDQTYuSmGPsPQvLIJdEYvQ_DsFq5Ez2Nh_QjiS3oZ3B8ZPfK9cZQyIStmQMV1lDPLw"
//        )
//        cell.posterIamgeView.kf.setImage(with: url)
        
        if indexPath.row == 4 {
            cell.backgroundColor = .yellow
        }
        
        return cell
    }
    
    // 현재 이 뷰는 모든 셀의 높이가 동일한데 이 함수를 실행하면 매번 실행됨 심지어 여러개씩.. 코스트가 너무 큼
    // 그래서 이 함수를 사용하지말고 viewDidRoad 시점에서 tableView.rowHeight = 80 을 넣어서 불필요한 함수 호출을 줄여보자
    // 근데 그러면 왜 이 함수 씀? 프로퍼티 사용하면 되는데? ㅋㅋ
    // 라고 한다면.. 모든 셀의 높이가 항상 같지 않을 경우가 있을텐데, 그럴 때 특정 셀의 높이를 바꿔줘야 할 때 사용하는 거임
    // 여기서 궁금한점! 만약에 고작 하나의 셀의 크기를 키우기 위해서 heightForRowAt을 사용해야 하나? 라는 생각 ..
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function, indexPath.row)
        
        if indexPath.row == 0 {
            return 160
        }
        
        return 80
    }

}
