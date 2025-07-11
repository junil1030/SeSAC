//
//  MagazineTableViewController.swift
//  task02
//
//  Created by 서준일 on 7/12/25.
//

import UIKit

class MagazineTableViewController: UITableViewController {

    let magazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 430
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineCell", for: indexPath) as! MagazineTableViewCell
        
        cell.configure(with: magazine[indexPath.row])
        
        return cell
    }

}
