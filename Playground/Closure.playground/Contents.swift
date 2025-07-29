import UIKit

func hello(name: String) -> String {
    print(#function)
    return "저는 \(name)입니다."
}

func hello(userName: String) -> String {
    print(#function)
    return "저는 \(userName)입니다."
}

func hello() {
    print(#function)
    print("안녕하세요")
}

let a = hello(name:)
a("jack")

// 1. 변수나 상수에 함수를 저장할 수 있다.
// 2. 매개변수에 함수를 사용할 수 있다.
func checkBankInformation(bank: String) -> Bool {
    let bankArray = ["국민", "우리", "신한"]
    
    return bankArray.contains(bank) ? true : false
}

// 이 코드는 함수가 실행된 반환값인 Bool이 jack에 저장된 것.
let jack = checkBankInformation(bank: "대구")

print(jack)

// 함수만 상수에 담은 것으로, 실행은 아직 안됨
// 일급객체는 상수/변수에 담을 수 있다.
let account = checkBankInformation

let result = account("신한")
print(result)

func average(a: Int, b: Int) -> Int {
    return (a + b) / 2
}

let value = average(a: 3, b: 5)
print("평균 \(value)점 입니다.")

let functionType = average

print("이 평균은 \(functionType(20, 40))입니다.")


// 2. 매개변수에 함수를 사할 수 있다.
// () -> Void

func oddNumber() {
    print("홀수입니다.")
}

func evenNumber() {
    print("짝수입니다.")
}

func calculateNumber(number: Int, odd: () -> Void, even: () -> Void) {
    return number.isMultiple(of: 2) ? even() : odd()
}

calculateNumber(number: 3, odd: oddNumber, even: evenNumber)

// 클로저 축약형태
calculateNumber(number: 2381230) {
    print("홀수야")
} even: {
    print("짝수야")
}


// 이름 없는 함수를 어떻게 쓸까
func study() {
    print("Study hard")
}

let studyHard = {
    print("iOS Study Hard")
}

// 클로저 헤더 in 클로저 바디
let studyHard2 = { () -> Void in
    print("iOS Study Hard")
}

func studyWithMe(study: () -> Void) {
    study()
}

studyWithMe {
    print("")
}

// 트레일링 클로저
studyWithMe { () -> Void in
    print("hello")
    print("hi")
}

// 이름 없는 함수를 어떻게 쓸까
// (Int) -> String
func randomNumber(number: Int) -> String {
    let random = Int.random(in: 1...number)
    return "오늘의 행운의 숫자는 \(random)"
}

let _ = randomNumber

randomNumber(number: 100)

func todayNumber(result: (Int) -> String) {
    
}

todayNumber(result: { (jack: Int) -> String in
    let random = Int.random(in: 1...jack)
    return "오늘의 행운의 숫자는 \(random)입니다."
})
