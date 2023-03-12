//
//  AcceptTermsViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/11.
//

import Foundation
import RxSwift
import RxRelay

class AcceptTermsViewModel {
    
    var termObservale = BehaviorRelay<[Term]>(value: [])
    
    let titleArr = ["(필수) 엠닥홈케어 이용약관 동의",
                    "(필수) 개인정보 수집 및 이용 동의",
                    "(선택) 광고성 정보 수신 동의",
                    "만 14세 이상 회원입니다."]
    
    init() {
        let terms: [Term] = [
            Term(id: 0, checked: false, title: titleArr[0]),
            Term(id: 1, checked: false, title: titleArr[1]),
            Term(id: 2, checked: false, title: titleArr[2]),
            Term(id: 3, checked: false, title: titleArr[3])
        ]
        termObservale.accept(terms)
    }
    
    func checkTerm(_ id: Int) {
        _ = termObservale
            .map { terms in
                terms.map { t in
                    if t.id == id {
                        return t.termAccepted()
                    } else {
                        return t.termOriginal()
                    }
                }
            }
            .take(1)
            .subscribe(onNext: {
                self.termObservale.accept($0)
            })
    }
}
