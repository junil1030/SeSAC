//
//  ViewModelProtocol.swift
//  Rx+Example
//
//  Created by 서준일 on 8/29/25.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    var disposeBag: DisposeBag { get }
    
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
