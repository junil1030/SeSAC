//
//  DynamicTableViewController.swift
//  task01
//
//  Created by 서준일 on 7/9/25.
//

import UIKit

class DynamicTableViewController: UITableViewController {

    let sectionName: [(sectionTitle: String, rowTitles: [String])] = [
        (sectionTitle: "전체설정", rowTitles: ["공지사항", "실험실", "버전 정보"]),
        (sectionTitle: "개인 설정", rowTitles: ["개인/보안", "알림", "채팅", "멀티프로필"]),
        (sectionTitle: "기타", rowTitles: ["고객센터/도움말"])
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.rowHeight = 44
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionName.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionName[section].sectionTitle
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = sectionName[indexPath.section].rowTitles[indexPath.row]
        
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionName[section].rowTitles.count
    }
}
