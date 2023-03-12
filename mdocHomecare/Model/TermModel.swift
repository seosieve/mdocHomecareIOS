//
//  TermModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/16.
//

import Foundation

struct Term {
    var id: Int
    var checked: Bool
    var title: String
    
    func termAccepted() -> Term {
        return Term(id: id, checked: true, title: title)
    }
    
    func termOriginal() -> Term {
        return Term(id: id, checked: true, title: title)
    }
}


