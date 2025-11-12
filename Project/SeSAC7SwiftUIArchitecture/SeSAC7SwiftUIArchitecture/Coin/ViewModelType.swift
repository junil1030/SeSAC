//
//  ViewModelType.swift
//  SeSAC7SwiftUIArchitecture
//
//  Created by 서준일 on 11/11/25.
//

import Foundation
import Combine

protocol ViewModelType: AnyObject, ObservableObject {
    associatedtype Input
    associatedtype Output
    
    var cancellables: Set<AnyCancellable> { get set }
    
    var input: Input { get set }
    var output: Output { get set }
    
    func transform()
}
