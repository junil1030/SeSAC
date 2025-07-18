//
//  CityInfoTableViewController.swift
//  task01
//
//  Created by 서준일 on 7/18/25.
//

import UIKit

class CityInfoTableViewController: UITableViewController {

    private let cityInfo = CityInfo().city
    private var filteredCityInfo: [City] = []
    
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "인기 도시"
        tableView.rowHeight = 150
        filteredCityInfo = cityInfo

    }
    
    private func registerXib() {
        let xib = UINib(nibName: CityInfoTableViewCell.identifier, bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: CityInfoTableViewCell.identifier)
    }
    
    private func setupSegment() {
        segment.removeAllSegments()
        let segmentItems = ["모두", "국내", "해외"]
        for (index, title) in segmentItems.enumerated() {
            segment.insertSegment(withTitle: title, at: index, animated: false)
        }
        segment.selectedSegmentIndex = 0
        segment.addTarget(self, action: #selector(segmentChanged(_:)), for: .valueChanged)
    }

    private func filterCity(for index: Int) {
        switch index {
        case 1:
            filteredCityInfo = cityInfo.filter { $0.domestic_travel }
        case 2:
            filteredCityInfo = cityInfo.filter { !$0.domestic_travel }
        default:
            filteredCityInfo = cityInfo
        }
        tableView.reloadData()
    }
    
    @objc func segmentChanged(_ sender: UISegmentedControl) {
        filterCity(for: sender.selectedSegmentIndex)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCityInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier, for: indexPath) as! CityInfoTableViewCell
        
        cell.configureData(with: filteredCityInfo[indexPath.row])
        
        return cell
    }
}
