//
//  ImageModel.swift
//  SeSAC7Week5
//
//  Created by 서준일 on 7/31/25.
//

import Foundation

struct Photo: Decodable {
    let id: String
    let author: String
    let url: String
}

struct PhotoDummyData {
    
    // 첫 번째 그룹 (20개)
    static let firstGroup: [Photo] = [
        Photo(id: "30", author: "Shyamanta Baruah", url: "https://picsum.photos/id/30/1280/901"),
        Photo(id: "31", author: "How-Soon Ngu", url: "https://picsum.photos/id/31/3264/4912"),
        Photo(id: "32", author: "Rodrigo Melo", url: "https://picsum.photos/id/32/4032/3024"),
        Photo(id: "33", author: "Alejandro Escamilla", url: "https://picsum.photos/id/33/5000/3333"),
        Photo(id: "34", author: "Aleks Dorohovich", url: "https://picsum.photos/id/34/3872/2592"),
        Photo(id: "35", author: "Shane Colella", url: "https://picsum.photos/id/35/2758/3622"),
        Photo(id: "36", author: "Vadim Sherbakov", url: "https://picsum.photos/id/36/4179/2790"),
        Photo(id: "37", author: "Austin Neill", url: "https://picsum.photos/id/37/2000/1333"),
        Photo(id: "38", author: "Allyson Souza", url: "https://picsum.photos/id/38/1280/960"),
        Photo(id: "39", author: "Luke Chesser", url: "https://picsum.photos/id/39/3456/2304"),
        Photo(id: "40", author: "Ryan Mcguire", url: "https://picsum.photos/id/40/4106/2806"),
        Photo(id: "41", author: "Nithya Ramanujam", url: "https://picsum.photos/id/41/1280/805"),
        Photo(id: "42", author: "Luke Chesser", url: "https://picsum.photos/id/42/3456/2304"),
        Photo(id: "43", author: "Oleg Chursin", url: "https://picsum.photos/id/43/1280/831"),
        Photo(id: "44", author: "Christopher Sardegna", url: "https://picsum.photos/id/44/4272/2848"),
        Photo(id: "45", author: "Alan Haverty", url: "https://picsum.photos/id/45/4592/2576"),
        Photo(id: "46", author: "Jeffrey Kam", url: "https://picsum.photos/id/46/3264/2448"),
        Photo(id: "47", author: "Christopher Sardegna", url: "https://picsum.photos/id/47/4272/2848"),
        Photo(id: "48", author: "Luke Chesser", url: "https://picsum.photos/id/48/5000/3333"),
        Photo(id: "49", author: "Margaret Barley", url: "https://picsum.photos/id/49/1280/792")
    ]
    
    // 두 번째 그룹 (20개)
    static let secondGroup: [Photo] = [
        Photo(id: "50", author: "Tyler Wanlass", url: "https://picsum.photos/id/50/4608/3072"),
        Photo(id: "51", author: "Ireneuilia", url: "https://picsum.photos/id/51/5000/3333"),
        Photo(id: "52", author: "Cierra", url: "https://picsum.photos/id/52/1280/853"),
        Photo(id: "53", author: "J Duclos", url: "https://picsum.photos/id/53/1280/1280"),
        Photo(id: "54", author: "Nicholas Swanson", url: "https://picsum.photos/id/54/3264/2176"),
        Photo(id: "55", author: "Tyler Wanlass", url: "https://picsum.photos/id/55/4608/3072"),
        Photo(id: "56", author: "Sebastian Muller", url: "https://picsum.photos/id/56/2880/1920"),
        Photo(id: "57", author: "Nicholas Swanson", url: "https://picsum.photos/id/57/2448/3264"),
        Photo(id: "58", author: "Tony Naccarato", url: "https://picsum.photos/id/58/1280/853"),
        Photo(id: "59", author: "Art Wave", url: "https://picsum.photos/id/59/2464/1632"),
        Photo(id: "60", author: "Michael Henry", url: "https://picsum.photos/id/60/1920/1200"),
        Photo(id: "61", author: "Samuel Zeller", url: "https://picsum.photos/id/61/3264/2176"),
        Photo(id: "62", author: "Annie Spratt", url: "https://picsum.photos/id/62/2016/1512"),
        Photo(id: "63", author: "David Marcu", url: "https://picsum.photos/id/63/5000/2813"),
        Photo(id: "64", author: "John Towner", url: "https://picsum.photos/id/64/4326/2884"),
        Photo(id: "65", author: "Benjamin Combs", url: "https://picsum.photos/id/65/4912/3264"),
        Photo(id: "66", author: "Ales Krivec", url: "https://picsum.photos/id/66/3264/2448"),
        Photo(id: "67", author: "Jaromír Kavan", url: "https://picsum.photos/id/67/2848/4288"),
        Photo(id: "68", author: "Modestas Urbonas", url: "https://picsum.photos/id/68/4608/3072"),
        Photo(id: "69", author: "Shin Roran", url: "https://picsum.photos/id/69/4912/3264")
    ]
    
    // 전체 데이터 (40개)
    static let allPhotos: [Photo] = firstGroup + secondGroup
}

