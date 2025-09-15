//
//  WishList.swift
//  task01
//
//  Created by 서준일 on 9/15/25.
//

import Foundation

struct WishList: Hashable {
    let todo: String
    let date: String
    
    static let dummyData: [WishList] = [
        WishList(todo: "제주도 여행가기", date: "2025-10-15"),
        WishList(todo: "Swift 공부하기", date: "2025-09-20"),
        WishList(todo: "헬스장 등록하기", date: "2025-09-25"),
        WishList(todo: "새 아이폰 사기", date: "2025-11-01"),
        WishList(todo: "책 10권 읽기", date: "2025-12-31"),
        WishList(todo: "요리 배우기", date: "2025-10-30"),
        WishList(todo: "친구들과 캠핑하기", date: "2025-11-10"),
        WishList(todo: "영어회화 수업 듣기", date: "2025-09-30"),
        WishList(todo: "새 노트북 구매", date: "2025-12-01"),
        WishList(todo: "부모님께 안마의자 선물", date: "2025-10-20"),
        WishList(todo: "드라이브 코스 찾아보기", date: "2025-09-22"),
        WishList(todo: "새로운 취미 찾기", date: "2025-10-05"),
        WishList(todo: "다이어트 시작하기", date: "2025-09-18"),
        WishList(todo: "콘서트 티켓 예매", date: "2025-11-15"),
        WishList(todo: "반려동물 키우기", date: "2026-01-01"),
        WishList(todo: "새 운동화 사기", date: "2025-09-28"),
        WishList(todo: "카페 창업 준비", date: "2026-03-01"),
        WishList(todo: "해외여행 계획 세우기", date: "2025-11-20"),
        WishList(todo: "새 차 구매하기", date: "2025-12-15"),
        WishList(todo: "홈카페 꾸미기", date: "2025-10-10"),
        WishList(todo: "iOS 앱 출시하기", date: "2025-12-25"),
        WishList(todo: "사진 촬영 배우기", date: "2025-10-25"),
        WishList(todo: "마라톤 완주하기", date: "2026-04-01"),
        WishList(todo: "새 옷 쇼핑하기", date: "2025-09-26"),
        WishList(todo: "기타 배우기", date: "2025-11-05"),
        WishList(todo: "독서실 등록하기", date: "2025-09-23"),
        WishList(todo: "맛집 탐방하기", date: "2025-10-08"),
        WishList(todo: "새 침대 구매", date: "2025-11-30"),
        WishList(todo: "블로그 시작하기", date: "2025-10-01"),
        WishList(todo: "자격증 취득하기", date: "2025-12-10"),
        WishList(todo: "새 향수 사기", date: "2025-09-29"),
        WishList(todo: "방 인테리어 바꾸기", date: "2025-11-25"),
        WishList(todo: "새 핸드폰 케이스 구매", date: "2025-09-21"),
        WishList(todo: "온라인 강의 수강", date: "2025-10-15"),
        WishList(todo: "새 가방 사기", date: "2025-10-12"),
        WishList(todo: "치과 검진 받기", date: "2025-09-27"),
        WishList(todo: "새 책상 구매하기", date: "2025-11-08"),
        WishList(todo: "피아노 배우기", date: "2025-12-05"),
        WishList(todo: "새 시계 사기", date: "2025-10-18"),
        WishList(todo: "헤어스타일 바꾸기", date: "2025-09-24"),
        WishList(todo: "새 안경 맞추기", date: "2025-10-03"),
        WishList(todo: "요가 수업 듣기", date: "2025-10-28"),
        WishList(todo: "새 이어폰 구매", date: "2025-09-19"),
        WishList(todo: "영화관 데이트", date: "2025-10-06"),
        WishList(todo: "새 지갑 사기", date: "2025-11-12"),
        WishList(todo: "미용실 예약하기", date: "2025-09-30"),
        WishList(todo: "새 컴퓨터 조립", date: "2025-12-20"),
        WishList(todo: "스키장 가기", date: "2025-12-28"),
        WishList(todo: "새 모니터 구매", date: "2025-11-18"),
        WishList(todo: "건강검진 받기", date: "2025-10-22")
    ]
}
