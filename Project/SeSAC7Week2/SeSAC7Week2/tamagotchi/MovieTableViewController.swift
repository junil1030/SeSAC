//
//  MovieTableViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class MovieTableViewController: UITableViewController {

    @IBOutlet var movieTextField: UITextField!
    var movie = ["쥬라기공원", "어벤져스", "괴물", "겨울왕국"]
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func checkButtonClicked(_ sender: UIButton) {
        if let text = movieTextField.text, !text.isEmpty {
            movie.append(text)
            tableView.reloadData()
            print(movie)
        }
    }
    
    // MARK: - Table view data source
    
    // 1. 셀 갯수
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        print(#function)
        return movie.count
    }
    
    // 2. 디자인
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function, indexPath)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        
        cell.textLabel?.text = movie[indexPath.row]
        
        if indexPath.row == 4 {
            cell.backgroundColor = .yellow
        } else {
            cell.backgroundColor = .gray
        }
        
        return cell
    }
    
    // 3. 높이
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 80
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function)
        
        if indexPath.row == 0 {
            movie.remove(at: 0)
            tableView.reloadData()
        }
    }
}
