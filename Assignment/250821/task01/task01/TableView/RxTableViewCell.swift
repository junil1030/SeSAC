//
//  RxTableViewCell.swift
//  task01
//
//  Created by 서준일 on 8/21/25.
//

import UIKit
import SnapKit

class RxTableViewCell: UITableViewCell {
    
    static let identifier = "RxTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupCell()
    }
    
    private func setupCell() {
        accessoryType = .detailButton
        selectionStyle = .default
        
        textLabel?.font = UIFont.systemFont(ofSize: 16)
        textLabel?.textColor = .label
    }
    
    func configure(with text: String, row: Int) {
        textLabel?.text = "\(text) @ row \(row)"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
    }
}
