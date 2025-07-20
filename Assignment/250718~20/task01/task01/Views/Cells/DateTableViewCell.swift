//
//  DateTableViewCell.swift
//  task01
//
//  Created by 서준일 on 7/20/25.
//

import UIKit

class DateTableViewCell: UITableViewCell {
    
    static let identifier = "DateTableViewCell"

    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .clear
        selectionStyle = .none
        dateLabel.textAlignment = .center
    }
    
    func configureDate(_ dateString: String) {
        dateLabel.text = dateString.dateFormatted(to: .yyyyMMdd)
    }
}
