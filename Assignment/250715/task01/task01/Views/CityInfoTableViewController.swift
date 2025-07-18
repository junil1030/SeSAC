//
//  CityInfoTableViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class CityInfoTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "인기 도시"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

}
