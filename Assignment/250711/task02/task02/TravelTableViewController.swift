//
//  TravelTableViewController.swift
//  task02
//
//  Created by 서준일 on 7/12/25.
//

import UIKit

class TravelTableViewController: UITableViewController {

    let travelInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentInfo = travelInfo[indexPath.row]
        
        if currentInfo.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ADCell", for: indexPath) as! TravelADTableViewCell
            cell.configure(with: currentInfo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CityCell", for: indexPath) as! TravelCityTableViewCell
            cell.configure(with: currentInfo)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentInfo = travelInfo[indexPath.row]
        return currentInfo.ad ? 90 : 150
    }
}
