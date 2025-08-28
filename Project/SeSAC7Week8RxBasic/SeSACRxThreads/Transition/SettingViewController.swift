//
//  SettingViewController.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/28/25.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import RxDataSources

struct JunSection {
    let header: String
    var items: [String]
}

extension JunSection: SectionModelType {
    init(original: JunSection, items: [String]) {
        self = original
        self.items = items
    }
}

struct MainData {
    let message: String
}

struct ExSection {
    let header: String
    var items: [Item]
}

extension ExSection: SectionModelType {
    typealias Item = MainData
    
    init(original: ExSection, items: [MainData]) {
        self = original
        self.items = items
    }
}

class SettingViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    private let tableView: UITableView = {
       let view = UITableView()
        view.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        view.backgroundColor = .lightGray
        view.rowHeight = 180
        view.separatorStyle = .none
       return view
     }()
    
    let items = Observable.just(["a", "b", "c"])
    
    let list = [
        JunSection(header: "전체 설정", items: ["공지사항", "실험실"]),
        JunSection(header: "개인 설정", items: ["알림", "채팅",  "프로필"]),
        JunSection(header: "기타", items: ["고객센터", "도움말"])
    ]
    
    let exList = [
        ExSection(header: "전체 설정", items: [MainData(message: "공지사항"), MainData(message: "실험실")]),
        ExSection(header: "개인 설정", items: [MainData(message: "알림"), MainData(message: "채팅"), MainData(message: "프로필")]),
        ExSection(header: "기타", items: [MainData(message: "고객센터"), MainData(message: "도움말")]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        exbind()
    }
    
    private func bind() {
        
        let dataSource = RxTableViewSectionedReloadDataSource<JunSection> { dataSource, tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
            
            cell.appNameLabel.text = item
            
            return cell
        }
        
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].header
        }
        
        Observable.just(list)
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
    }
    
    private func exbind() {
        
    }
    
    private func configureLayout() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
