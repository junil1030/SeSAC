//
//  ShoppingResponse.swift
//  task01
//
//  Created by 서준일 on 7/26/25.
//

import Foundation

// MARK: - 메인 응답 모델
struct ShoppingResponse: Codable {
    let lastBuildDate: String
    let total: Int
    let start: Int
    let display: Int
    let items: [ShoppingItem]
}

// MARK: - 상품 아이템 모델
struct ShoppingItem: Codable {
    let title: String
    let link: String
    let image: String
    let lprice: String
    let hprice: String
    let mallName: String
}

struct DummyData {
    static let dummyData: [ShoppingItem] = [
        ShoppingItem(
            title: "맨체스터시티 어웨이 25-26 유니폼 저지 맨시티 오피셜선수마킹",
            link: "https://smartstore.naver.com/main/products/12120555474",
            image: "https://shopping-phinf.pstatic.net/main_8966506/89665066179.jpg",
            lprice: "116000",
            hprice: "",
            mallName: "redsoccer"
        ),
        ShoppingItem(
            title: "푸마 맨시티 25-26 어웨이 유니폼 78035002 오피셜마킹",
            link: "https://smartstore.naver.com/main/products/12120628158",
            image: "https://shopping-phinf.pstatic.net/main_8966513/89665138863.jpg",
            lprice: "116000",
            hprice: "",
            mallName: "이지사커"
        ),
        ShoppingItem(
            title: "푸마 맨시티 어웨이 유니폼 23/24 770449 02",
            link: "https://smartstore.naver.com/main/products/9026845465",
            image: "https://shopping-phinf.pstatic.net/main_8657134/86571345788.1.jpg",
            lprice: "74000",
            hprice: "",
            mallName: "마이웨이홈"
        ),
        ShoppingItem(
            title: "푸마 맨시티 4th 오아시스 유니폼 저지 24/25 선수 마킹 패치",
            link: "https://smartstore.naver.com/main/products/10934200911",
            image: "https://shopping-phinf.pstatic.net/main_8847870/88478706946.1.jpg",
            lprice: "109000",
            hprice: "",
            mallName: "OFFFSIDE"
        ),
        ShoppingItem(
            title: "25-26 맨체스터시티 맨시티 멘시티 유니폼 홈 저지 남자 홀란드",
            link: "https://smartstore.naver.com/main/products/11835647865",
            image: "https://shopping-phinf.pstatic.net/main_8938015/89380158459.jpg",
            lprice: "118000",
            hprice: "",
            mallName: "호윤글로벌"
        ),
        ShoppingItem(
            title: "맨시티 유니폼 25-26시즌 스페셜 성인 유니폼 상의",
            link: "https://smartstore.naver.com/main/products/12066933730",
            image: "https://shopping-phinf.pstatic.net/main_8961144/89611444429.jpg",
            lprice: "27000",
            hprice: "",
            mallName: "트레이닝클럽"
        ),
        ShoppingItem(
            title: "푸마 맨시티 홈 유니폼 저지 24/25 선수 마킹 패치",
            link: "https://smartstore.naver.com/main/products/10334944741",
            image: "https://shopping-phinf.pstatic.net/main_8787944/87879448953.1.jpg",
            lprice: "99000",
            hprice: "",
            mallName: "OFFFSIDE"
        ),
        ShoppingItem(
            title: "푸마 맨시티 홈 유니폼 저지 23/24 선수 마킹 패치",
            link: "https://smartstore.naver.com/main/products/8574262561",
            image: "https://shopping-phinf.pstatic.net/main_8611876/86118762884.2.jpg",
            lprice: "114000",
            hprice: "",
            mallName: "OFFFSIDE"
        ),
        ShoppingItem(
            title: "25-26 맨체스터 시티 서드 어웨이 레플리카 져지 어린이/성인 반팔",
            link: "https://link.auction.co.kr/gate/pcs?item-no=F275157983",
            image: "https://shopping-phinf.pstatic.net/main_5574695/55746950125.jpg",
            lprice: "23860",
            hprice: "",
            mallName: "옥션"
        ),
        ShoppingItem(
            title: "푸마 맨체스터 시티 어웨이 저지 S S 클럽 유니폼 반팔",
            link: "https://search.shopping.naver.com/catalog/55903841657",
            image: "https://shopping-phinf.pstatic.net/main_5590384/55903841657.20250722164518.jpg",
            lprice: "99000",
            hprice: "",
            mallName: "네이버"
        )
    ]
}
