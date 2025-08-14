import UIKit

protocol MyDelegate: AnyObject  {
    func sendData()
}

class MainVC: MyDelegate {
    
    lazy var customView = {
        let view = DetailView()
        view.delegate = self
        return view
    }()
    
    init() {
        print("MainVC Init")
        customView
    }
    
    func sendData() {
        print("안녕하세요")
    }
    
    deinit {
        print("MainVC Deinit")
    }
}

class DetailView {
    
    weak var delegate: MyDelegate?
    
    func dismiss() {
        delegate?.sendData()
    }
    
    init() {
        print("DetailView Init")
    }
    
    deinit {
        print("DetailView Deinit")
    }
}

func testDeinit() {
    var view: MainVC? = MainVC()
    view?.sendData()
    view = nil
    print("함수 끝")
}

testDeinit()

class Person {
    let name: String
    lazy var introduce = { [weak self] in
        guard let self = self else { return }
        print("저는 \(self.name)입니다.")
    }
    
    init(name: String) {
        self.name = name
        print("Person init")
    }
    
    deinit {
        print("Person Deinit")
    }
}

var person: Person? = Person(name: "Jack")

person?.name
person?.introduce

person = nil

person?.name
person?.introduce

class Guild {
    var name: String
    weak var owner: User?
    
    init(name: String) {
        self.name = name
        print("Guild Init")
    }
    
    deinit {
        print("Guild Deinit")
    }
}

class User {
    var name: String
    weak var guild: Guild?
    
    init(name: String) {
        self.name = name
        print("User Init")
    }
    
    deinit {
        print("User Deinit")
    }
}

var sesac: Guild? = Guild(name: "새싹")
var user: User? = User(name: "홀란")

sesac?.owner = user
user?.guild = sesac

//sesac?.owner = nil
//user?.guild = nil

sesac = nil
user = nil
