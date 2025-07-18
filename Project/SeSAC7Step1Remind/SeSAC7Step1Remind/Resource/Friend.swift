//
//  Friend.swift
//  SeSAC7Step1Remind
//
//  Created by Jack on 7/16/25.
//

import Foundation
// 공간을 얼마나 많이 만들어서 쓰냐. 하나만 만들어서 쓰냐
// 인스턴스 프로퍼티(var, let) vs 타입 프로퍼티(static let, static var)

// 공간 안에 실질적인 데이터를 갖고 있냐 아니냐
// 저장 프로퍼티(=) vs 연산 프로퍼티( {} )

struct Friends {
    let name: String // Property
    let message: String?
    let profile_image: String?
    let phone: Int?
    var like: Bool
    
    // 연산 프로퍼티. 식판에 반찬 칸이 없음(?)
    var introduce: String {
        if phone != nil {
            return "\(name)님 (010\(phone!))"
        } else {
            return "\(name)님"
        }
    }
    
    var makeURL: URL? {
        if let imageURL = profile_image {
            return URL(string: imageURL)
        } else {
            return nil
        }
    }
}

struct FriendsInfo {
    let list: [Friends] = [
        Friends(
            name: "김민준",
            message: "오늘도 행복하세요 ☺️",
            profile_image: "https://picsum.photos/id/1/200/200",
            phone: 12345678,
            like: true
        ),
        Friends(
            name: "이서연",
            message: "여행 중 🛫",
            profile_image: "https://picsum.photos/id/10/200/200",
            phone: 23456789,
            like: true
        ),
        Friends(
            name: "박지훈",
            message: nil,
            profile_image: "https://picsum.photos/id/20/200/200",
            phone: 34567890,
            like: false
        ),
        Friends(
            name: "최예린",
            message: "인생은 단 한 번뿐이니까",
            profile_image: nil,
            phone: 45678901,
            like: true
        ),
        Friends(
            name: "정도현",
            message: "열심히 살자 💪",
            profile_image: "https://picsum.photos/id/30/200/200",
            phone: nil,
            like: false
        ),
        Friends(
            name: "강수아",
            message: "시험 기간 🔥",
            profile_image: "https://picsum.photos/id/40/200/200",
            phone: 56789012,
            like: true
        ),
        Friends(
            name: "윤준호",
            message: nil,
            profile_image: "https://picsum.photos/id/50/200/200",
            phone: 67890123,
            like: false
        ),
        Friends(
            name: "송미나",
            message: "꿈을 향해 한 걸음씩",
            profile_image: "https://picsum.photos/id/60/200/200",
            phone: 78901234,
            like: true
        ),
        Friends(
            name: "한태윤",
            message: "나를 믿어 ⭐️",
            profile_image: nil,
            phone: 89012345,
            like: false
        ),
        Friends(
            name: "임서현",
            message: "행복은 나의 선택",
            profile_image: "https://picsum.photos/id/70/200/200",
            phone: 90123456,
            like: true
        ),
        Friends(
            name: "오동준",
            message: nil,
            profile_image: "https://picsum.photos/id/80/200/200",
            phone: nil,
            like: false
        ),
        Friends(
            name: "신예은",
            message: "오늘도 감사한 하루 🙏",
            profile_image: "https://picsum.photos/id/90/200/200",
            phone: 1234567,
            like: true
        ),
        Friends(
            name: "구민석",
            message: "운동 중 🏃‍♂️",
            profile_image: nil,
            phone: 98765432,
            like: true
        ),
        Friends(
            name: "백지원",
            message: "하루하루 성장하는 중",
            profile_image: "https://picsum.photos/id/100/200/200",
            phone: 87654321,
            like: false
        ),
        Friends(
            name: "조현우",
            message: "낭만을 즐기는 중 🎸",
            profile_image: "https://picsum.photos/id/55/200/200",
            phone: 76543210,
            like: true
        ),
        Friends(
            name: "권나영",
            message: "꿈꾸는 대로 이루어질 거야",
            profile_image: "https://picsum.photos/id/77/200/200",
            phone: 65432109,
            like: true
        ),
        Friends(
            name: "황선재",
            message: "내 인생의 주인공",
            profile_image: nil,
            phone: 54321098,
            like: false
        ),
        Friends(
            name: "유민지",
            message: "독서 중 📚",
            profile_image: nil,
            phone: nil,
            like: true
        ),
        Friends(
            name: "안준영",
            message: "그대로의 내가 좋아",
            profile_image: "https://picsum.photos/id/110/200/200",
            phone: 43210987,
            like: false
        ),
        Friends(
            name: "남소희",
            message: "새로운 시작 ✨",
            profile_image: "https://picsum.photos/id/39/200/200",
            phone: 32109876,
            like: true
        )
    ]
}
