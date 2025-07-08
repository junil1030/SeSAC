import Foundation
// 1. 모두 초기화가 되어 있어야 한다. vc property init
// 초기값을 넣으면 되는데 방법이 여러 개 있음
// 1-1. 클래스의 모든 변수/상수를 초기화 하기
// 1-2. 옵셔널 선언: nil이 들어있기 때문에 값을 사용하면 앱이 터질 수 있음
// 1-3. 사용하기 직전에 초기화를 하면안됨? 되긴해

class User {
    var name: String // Instance Property
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    func hello() { // Instance Method
        print("안녕하세요")
    }
}

// 인스턴스 생성 / 인스턴스가 생김 / 인스턴스 / 등등...
var junil = User(name: "JunilSeo", age: 26)
junil.age
junil.name

let user = User(name: "Sleep", age: 10000)
user.name
user.age

struct Mentor {
    var name: String
    var age: Int
    
    // 기본 생성자의 제공
}
// class는 초기화 구문이 필요한데, struct는 기본적으로 제공해주는 게 있어서 필요 없긴 함
// 클래스는 상속이 된다.
// 멤버와이즈 이니셜라이저 (Memberwise Initialize)
let jun = Mentor(name: "junil", age: 26)

class BabyMonster {
    
    func attack() {
        print("공격")
    }
}

class BossMonster: BabyMonster {
    
//    override func attack() {
//        super.attack()
//        print("약공 끝")
//    }
    
    func bigAttack() {
        print("완전 큰 공격")
    }
}

let a = BossMonster()
a.attack
a.bigAttack()
