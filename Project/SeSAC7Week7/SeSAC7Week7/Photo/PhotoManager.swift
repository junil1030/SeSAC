//
//  PhotoManager.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/11/25.
//

import Foundation
import Alamofire

final class PhotoManager {
    
    static let shared = PhotoManager()
    
    private init() { }
    
    /*
     1. AF.request 메서드 하나를 활용할 수 없나?
     - endpoint, method를 한곳에서 관리하면? -> Router Pattern
     - generic, meta type
     2. 요청 로직을 한 곳에서 관리할 수 없나?
     */
    
    private func callRequest<T: Decodable>(api: PhotoRouter, success: @escaping (T) -> Void) {
        AF.request(api.endpoint, method: api.method, parameters: api.param).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                success(value)
            case .failure(let error):
                print(error)
            }
        }
    }

    func getOnePhoto(api: PhotoRouter, success: @escaping (Photo) -> Void) {
        callRequest(api: api, success: success)
    }
    
    func getPhotoList(api: PhotoRouter, success: @escaping ([PhotoList]) -> Void) {
        callRequest(api: api, success: success)
    }
}
