//
//  DateViewController.swift
//  SeSAC7Week6
//
//  Created by 서준일 on 8/7/25.
//

import UIKit
import SnapKit

// 오류 처리 패턴
enum BoxOfficeValidationError: Error{
    case emptyString
    case isNotInt
    case isNotDate
    
}

class DateViewController: UIViewController {
    
    let textField = UITextField()
    let button = UIButton()
    let label = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        configure()
        button.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    @objc func buttonClicked() {
        
        guard let text = textField.text, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            print("텍스트 필드 글자가 nil입니다.")
            return
        }
        
        /*
         1. enum error 3개를 모두 다 catch로 했는데 왜 catch { } 가 필요한가 ...
         2. boxOffice error 3개를 다 처리했더라도, Error를 채택했기 때문에 AFError 등과 같은 에러가 발생하는 순간이 존재할 것이기 때문에 나머지도 처리를 해줘야 한다..
         3. 귀찮더라도 try! try? 보다는 do try catch를 쓰는게 심신에 좋음 ..
         4. "절대 애플 Error가 발생하지 않는 상황인데 왜 굳이 써야할까?? 좀 편하게 바꿔줘"라고 말한다면 swift6에 새로 생겼음 !
         5. func validateUserInput(text: String) throws(BoxOfficeValidationError) -> Bool {
         6. 이런식으로 작성할 수 있음. 이 함수는 이 에러만 뜰 수 있어요~ 이런 의미겠죠
         */
        
//        let result = try? validateUserInput(text: text)
//        print(result)

        do {
            let result = try validateUserInput(text: text)
            
            label.text = "검색이 가능합니다."
            
        } catch {
            switch error {
            case .emptyString:
                print("")
            case .isNotInt:
                print("")
            case .isNotDate:
                print("")
            default:
                print("Some error")
            }
        }
    }
    
    // true 빼고 나머지는 다 잘못한거
    // false도 어떤 false인지 구체적으로 알고싶을 떄
    // 에러를 발생할 수 있다는 걸 알리기 위해 throw 키워드를 선언
    // throw 키워드가 표시된 함수: throw function
    //func validateUserInput(text: String) throws -> Bool {
    func validateUserInput(text: String) throws(BoxOfficeValidationError) -> Bool {
        // 빈 값
        guard !text.isEmpty else {
            throw BoxOfficeValidationError.emptyString
        }
        
        // 입력한 값이 숫자인지 아닌지
        guard Int(text) != nil else {
            throw BoxOfficeValidationError.isNotInt
        }
        
        // 입력한 값이 날짜 형태로 변환되는 지 아닌 지
        guard checkDateFormat(text: text) else {
            throw BoxOfficeValidationError.isNotDate
        }
        
        return true
    }
    
    func checkDateFormat(text: String) -> Bool {
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        return format.date(from: text) == nil ? false : true
    }
    
    func configure() {
        view.addSubview(textField)
        view.addSubview(button)
        view.addSubview(label)
        
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
        
        button.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(textField.snp.bottom).offset(20)
        }
        
        label.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            make.top.equalTo(button.snp.bottom).offset(20)
        }
        
        textField.placeholder = "텍스트필드"
        
        button.setTitle("버튼 클릭", for: .normal)
        button.backgroundColor = .red
        
        label.text = "레이블"
        label.backgroundColor = .yellow
    }
}
