//
//  TravelTableViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class TravelTableViewController: UITableViewController {
    
    private let travelInfo = TravelInfo().travel

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"

        let cityXib = UINib(nibName: "TravelCityTableViewCell", bundle: nil)
        let adXib = UINib(nibName: "TravelADTableViewCell", bundle: nil)
        tableView.register(cityXib, forCellReuseIdentifier: "TravelCityTableViewCell")
        tableView.register(adXib, forCellReuseIdentifier: "TravelADTableViewCell")
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
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelADTableViewCell.identifier, for: indexPath) as! TravelADTableViewCell
            cell.configure(with: currentInfo)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelCityTableViewCell.identifier, for: indexPath) as! TravelCityTableViewCell
            cell.configure(with: currentInfo)
            return cell
        }
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let currentInfo = travelInfo[indexPath.row]
        return currentInfo.ad ? 90 : 150
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentInfo = travelInfo[indexPath.row]
        
        if currentInfo.ad {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TravelADViewController.identifier) as! TravelADViewController
            let nav = UINavigationController(rootViewController: vc)
            
            vc.content = currentInfo
            nav.modalPresentationStyle = .fullScreen
            
            present(nav, animated: true, completion: nil)
        } else {
            let sb = UIStoryboard(name: "Main", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: TravelDetailViewController.identifier) as! TravelDetailViewController
            
            vc.content = currentInfo
            navigationController?.pushViewController(vc, animated: true)
        }
        

    }
}
