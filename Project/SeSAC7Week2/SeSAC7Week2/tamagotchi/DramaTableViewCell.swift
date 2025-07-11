//
//  DramaTableViewCell.swift
//  SeSAC7Week2
//
//  Created by 서준일 on 7/10/25.
//

import UIKit

class DramaTableViewCell: UITableViewCell {
    
    @IBOutlet var posterIamgeView: UIImageView!
    @IBOutlet var overviewLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // 사용할 셀을 만드는 작업 ..
        // 보통 화면에 보이는 셀의 갯수만큼 실행되면서 만들어 두는데,
        // (테스트 시에는 화면에 있는 갯수보다 조금 더 많음. 여러번 실행해도 항상 같은 갯수)
        // 초기화 작업을 수행해주는 함수라고 생각하면 편할 것 같다
        
        overviewLabel.numberOfLines = 0
        overviewLabel.textColor = .blue
        overviewLabel.font = .boldSystemFont(ofSize: 15)
        posterIamgeView.backgroundColor = .orange
        
        print(#function)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        print(#function)
        
        backgroundColor = .white
    }
}
