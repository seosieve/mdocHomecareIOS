//
//  UserInfoModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/30.
//

import Foundation

struct UserInfo {
    var name: String
    var phoneNumber: String
    var born: String
    var password: String
    var sex: String
    
    init(_ userData: [String]) {
        self.name = userData[1]
        self.phoneNumber = userData[3].makeGlobal()
        self.born = userData[2]
        self.password = userData[4]
        self.sex = userData[5]
    }
}
