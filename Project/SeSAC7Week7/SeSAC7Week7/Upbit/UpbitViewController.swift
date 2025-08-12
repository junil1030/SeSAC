//
//  UpbitViewController.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import UIKit
import SnapKit

class UpbitViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self,
                           forCellReuseIdentifier: "UserCell")
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
      
    let viewModel = UpbitViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupNavigationItems()
        bindData()
    }
    
    func bindData() {
        viewModel.inputViewDidLoadTrigger.value = ()
        
        viewModel.outputMarketData.bind {
            print("viewController OuptPutMarketData")
            self.tableView.reloadData()
        }
        
        viewModel.outputNavigationTitleData.bind {
            print("viewController OutputNavigationTitleData ", self.viewModel.outputNavigationTitleData.value)
            let value = self.viewModel.outputNavigationTitleData.value
            self.navigationItem.title = value
        }
        
        /*
         bind로 즉시 실행되어 화면 전환이 되고 있는 상황인데..
         - lazyBind로 해결하거나
         - Optional이거나 빈 값일 때에는 실행되지 않도록 Early Exit을 하거나
         */
        viewModel.outputSelectedTrigger.bind {
            print("viewController OutputSelectedTrigger ", self.viewModel.outputSelectedTrigger.value)
            let vc = UpbitDetailViewController()
            vc.viewModel.outputTitle.value = self.viewModel.outputSelectedTrigger.value?.korean_name
            self.navigationController?.pushViewController(vc, animated: true)
            self.navigationItem.backButtonTitle = ""
        }
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubview(tableView)
         
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func setupNavigationItems() {
        navigationItem.title = "마켓 목록"
    }
}

extension UpbitViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputMarketData.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath)
        let row = viewModel.outputMarketData.value[indexPath.row]
        cell.textLabel?.text = row.overview
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(#function, indexPath.row)
        
        let row = viewModel.outputMarketData.value[indexPath.row]
        viewModel.inputCellSelectedTrigger.value = row
    }
    
}
