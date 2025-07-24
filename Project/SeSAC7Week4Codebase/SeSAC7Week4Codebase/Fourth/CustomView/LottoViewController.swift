//
//  LottoViewController.swift
//  SeSAC7Week4Codebase
//
//  Created by 서준일 on 7/24/25.
//

import UIKit
import Alamofire
import SnapKit

class LottoViewController: UIViewController {
    
    let resultLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(resultLabel)
        resultLabel.snp.makeConstraints { make in
            make.size.equalTo(100)
            make.center.equalTo(view)
        }
        
        resultLabel.backgroundColor = .yellow
        resultLabel.text = "Text"
        
        callRequest()
    }
    
    func callRequest() {
        print(#function)
        print("callRequest Start")
        let url = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo=1181"
        AF.request(url, method: .get)
            .validate(statusCode: 200..<300)
            .responseDecodable(of: Lotto.self) { response in
            switch response.result {
            case .success(let lotto):
                print("success", lotto)
                self.resultLabel.text = lotto.drwNoDate
            case .failure(let error):
                print("error", error)
            }
        }
        print("callRequest End")
    }
}
