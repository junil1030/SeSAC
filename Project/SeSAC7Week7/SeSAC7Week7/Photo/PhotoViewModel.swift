//
//  PhotoViewModel.swift
//  SeSAC7Week7
//
//  Created by Jack on 8/12/25.
//

import Foundation

final class PhotoViewModel {
    
    var input: Input
    var output: Output
    
    struct Input {
        var searchButtonTapped = ReviewObservable<Void>(())
        var text = ReviewObservable<String?>(nil)
        var fetchButtonTapped = ReviewObservable<Void>(())
    }
    
    struct Output {
//        var photo = ReviewObservable<Photo?>(nil)
        var list = ReviewObservable<[PhotoList]>([])
        var image = ReviewObservable<URL?>(nil)
        var overView = ReviewObservable<String>("작가: - , 해상도: - ")
    }
    
    init() {
        input = Input()
        output = Output()
        
        transform()
    }
    
    private func transform() {
        input.searchButtonTapped.lazyBind {
            print("Input searchButtonTapped bind")
            self.getPhoto()
        }
        
        input.searchButtonTapped.bind {
            self.getPhotoList()
        }
    }
    
    private func getPhotoList() {
        PhotoManager.shared.getPhotoList(api: .list) { photoList in
            self.output.list.value = photoList
        }
    }
    
    private func getPhoto() {
        guard let text = input.text.value, let photoId = Int(text), photoId >= 0 && photoId <= 100 else {
            print("0~100 사이의 숫자를 입력해주세요.")
            return
        }
        
        PhotoManager.shared.getOnePhoto(api: .one(id: photoId)) { photo in
            let data = "작가: \(photo.author), 해상도: \(photo.width) x \(photo.height)"
            
            self.output.overView.value = data
            
            let url = URL(string: photo.download_url)
            self.output.image.value = url
        }
    }
}
