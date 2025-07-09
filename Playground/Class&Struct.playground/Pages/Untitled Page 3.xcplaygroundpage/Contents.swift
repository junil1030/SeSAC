//: [Previous](@previous)

import Foundation

class Mentor {
    
    func mentoring() {
        print("멘토링 하세요")
    }
}

class Den: Mentor {
    
    func study() {
        print("공부하기")
    }
    
    func sleep() {
        print("잠자기")
    }
    
    override func mentoring() {
        super.mentoring()
        
        print("화이팅하세요")
    }
}

let den = Den()
den.mentoring()


//: [Next](@next)
