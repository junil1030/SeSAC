//
//  FirstTableTableViewController.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/9/25.
//

import UIKit

class FirstTableTableViewController: UITableViewController {

    let list = ["Jack", "Finn", "Den", "Hue", "Bran"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(#function)
    }
    
    // 1. 셀 갯수: numberOfRowsInSection
    // ex) 카카오톡 친구 300명
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return 300
    }
    // 2. 셀 디자인 및 데이터 처리: cellForRowAt
    // ex) 친구마다 프로필 이미지, 상태메시지, 닉네임 등 다 다름
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstCell", for: indexPath)
        
        cell.textLabel?.text = list[0]
        
        return cell
    }
    // 3. 셀 높이
    // ex.
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        print(#function)
        
        return 100
    }
    
}
