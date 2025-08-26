//
//  HomeworkViewModel.swift
//  SeSACRxThreads
//
//  Created by 서준일 on 8/26/25.
//

import Foundation
import RxSwift
import RxCocoa

final class HomeworkViewModel {
    
    private let disposeBag = DisposeBag()
    
    struct Input {
        let searchTap: ControlEvent<Void>
        let searchText: ControlProperty<String>
        let cellSelected: ControlEvent<Lotto>
    }
    
    let list: BehaviorRelay<[Lotto]> = BehaviorRelay(value: [])
    let items = BehaviorRelay(value: ["a", "b", "c"])
    
    struct Output {
        let list:  BehaviorRelay<[Lotto]>
        let items:  BehaviorRelay<[String]>
        let showAlert: PublishRelay<Bool>
    }
    
    func transform(input: Input) -> Output {
        
        let list = BehaviorRelay(
            value: [Lotto(drwNoDate: "테스트", firstAccumamnt: 10)]
        )
        
        let items = BehaviorRelay(value: ["1", "2", "3"])
        
        let showAlert = PublishRelay<Bool>()
        
        input.cellSelected
            .map { "셀 \($0.firstAccumamnt)" }
            .bind(with: self) { _, number in
                var original = items.value
                original.insert(number, at: 0)
                
                print(number)
                items.accept(original)
            }
            .disposed(by: disposeBag)
        
        // 검색에 실패하게 되면 Dispose가 켜지고 구독이 끊긴 상태로 끝남
        // 그래서 그 이후에 정상적인 호출이 가능한 검색을 해도 검색이 되지 않는 거임
        // 이걸 타개할 방법은 3가지 정도
        // 1. retry: 더 시도를 해보고 안되더라도 다시 구독을 함 / 즉, 사용자가 잘 입력을 하도록 기도해야되는 기도메타
        // 2. catch / catchAndReturn -> 전자는 에러에 따라 다른 값을 리턴 하는 등의 대체 로직이 수행되는 코드이고 후자는 간단한 기본값을 전달하는 것
        //      근데 이거는 다시 구독을 해주지 않는데 그러면 어떻게 써야할까?
        //      부모에서 사용하는게 아니고 자식에서 사용을 해야함 즉, 아래 코드처럼 getLotto에서 오류가 발생하고 다시 뭔가를 전달하는 로직이 들어갔기 때문에 CustomObservable만 dispose가 되었고
        //      SearchTap은 오류가 났는지 어떤 상황인지 자체를 알 수 없음 단지 just로 오는 오류나, 성공한 데이터가 들어오면 그걸 받기만 할 뿐임
        // 3. Error 상황에서도 그냥 뭔가를 보내자
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLotto(query: text)
                    .catch { _ in
                        // 새로운 스트림을 만드는데 아무 이벤트를 안주는 스트림을 쓸 수도 있음
                        return Observable.never()
                    }
//                    .catch { error in
//                        let a = Lotto(drwNoDate: "테스트", firstAccumamnt: 0)
//                        return  Observable.just(a)
//                    }
                
//                    .catchAndReturn(Lotto(drwNoDate: "테스트", firstAccumamnt: 0))
//                    .debug("커스텀 옵저버블 겟 로또")
            }
            .debug("서치바 옵저버블")
//            .retry()
//            .catchAndReturn(
//                Lotto(drwNoDate: "문제생김", firstAccumamnt: 0)
//            )
//            .catch { <#any Error#> in
//                <#code#>
//            }
            .subscribe(with: self) { owner, response in
                print("onNext", response)
                
                switch response {
                case .success(let value):
                    var data = list.value
                    data.insert(value, at: 0)
                    list.accept(data)
                case .failure(let error):
                    print(error)
                    showAlert.accept(true)
                }
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)
        
//=================================================================
        
        input.searchTap
            .withLatestFrom(input.searchText)
            .distinctUntilChanged()
            .flatMap { text in
                CustomObservable.getLottoWithSingle(query: text)
            }
            .debug("서치바 옵저버블")
            .subscribe(with: self) { owner, response in
                print("onNext", response)
                
                    
            } onError: { owner, error in
                print("onError", error)
            } onCompleted: { owner in
                print("onCompleted")
            } onDisposed: { owner in
                print("onDisposed")
            }
            .disposed(by: disposeBag)

        
        
        
        return Output(list: list, items: items, showAlert: showAlert)
    }
    
}
