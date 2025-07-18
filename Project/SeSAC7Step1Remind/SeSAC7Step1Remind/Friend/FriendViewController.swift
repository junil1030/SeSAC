//
//  FriendViewController.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import UIKit
/*
 - 아웃렛 필요.
 - 부하직원 호출. UITableViewDelegate, UITableViewDataSource
 - 메서드 호출. number- cell- ...
 - 테이블뷰랑 부하직원 연결
 */
class FriendViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
     
    @IBOutlet var mySearchBar: UISearchBar!
    @IBOutlet var myTableView: UITableView!
    
    private var list = FriendsInfo().list //필터링된 데이터
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self, #function)
        configureBackgroundColor()
        configureTableView()
    }
    
    @IBAction private func totalButtonClicked(_ sender: UIButton) {
    }
    
    //20명 > 10명
    @IBAction private func profileButtonClicked(_ sender: UIButton) {
        print(#function)
        //전체 데이터
        let all = FriendsInfo().list
        
        var filter: [Friends] = []
        
        for item in all {
            if item.profile_image != nil {
                filter.append(item)
                print("조건문", item)
            }
        }
        dump(filter)
        list = filter
        myTableView.reloadData()
    }
    
    @IBAction private func filterButtonClicked(_ sender: UIButton) {
        
        let all = FriendsInfo().list
        
        var filter: [Friends] = []
        
        for item in all {
            if item.like {
                filter.append(item)
            }
        }
        
        list = filter
        myTableView.reloadData()
        
    }
    
    
    private func configureTableView() {
        print(#function)
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.backgroundColor = .clear
        
        
//        myTableView.rowHeight = 100
        let noProfileXib = UINib(nibName: "NoProfileTableViewCell", bundle: nil)
        let ProfileXib = UINib(nibName: "ProfileTableViewCell", bundle: nil)
        myTableView.register(noProfileXib, forCellReuseIdentifier: "NoProfileTableViewCell")
        myTableView.register(ProfileXib, forCellReuseIdentifier: "ProfileTableViewCell")
    }
    
    @objc
    private func likeButtonClicked(_ sender: UIButton) {
        print(#function, sender.tag)
        //0번 셀 버튼 > list[0].like
        //1번 셀 버튼 > list[indexPath.row].like
        
        dump("Before")
        dump(list[sender.tag])

//        list[sender.tag].like = !list[sender.tag].like
        
        list[sender.tag].like.toggle()
        
//        if list[sender.tag].like == true {
//            list[sender.tag].like = false
//        } else {
//            list[sender.tag].like = true
//        }
        
        dump("After")
        dump(list[sender.tag])
        
        myTableView.reloadRows(
            at: [IndexPath(row: sender.tag, section: 0)], with: .fade)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(#function)
        return list.count
    }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print(#function)
        
        if list[indexPath.row].profile_image == nil {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoProfileTableViewCell", for: indexPath) as! NoProfileTableViewCell
            
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonClicked),
                                      for: .touchUpInside)

            cell.configureData(with: list[indexPath.row])
      
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileTableViewCell", for: indexPath) as! ProfileTableViewCell
            cell.configureData(with: list[indexPath.row])
            return cell
        }
        
        // 1. 절대 달라지지 않을 정적인 디자인
        // 2. 데이터 기반
        //section이 하나일 떄만
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if list[indexPath.row].profile_image == nil {
            return 150
        } else {
            return 100
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let sb = UIStoryboard(name: "Detail", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
           
//        vc.name = list[indexPath.row].name
//        vc.message = list[indexPath.row].message
//        vc.phone = list[indexPath.row].phone
        
        vc.profile = list[indexPath.row]
        
        present(vc, animated: true)
        
    }


}

