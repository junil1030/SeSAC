//
//  ReusableViewProtocol.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 8/4/25.
//

import UIKit

protocol ResusableViewProtocol {
    static var identifier: String { get }
}

extension ResusableViewProtocol {
    
}

extension UIViewController {
    
    static var identifier: String {
        return String(describing: self)
    }
}

extension UITableViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }}

extension UICollectionViewCell {
    
    static var identifier: String {
        return String(describing: self)
    }
}
