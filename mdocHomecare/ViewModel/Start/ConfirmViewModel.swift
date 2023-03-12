//
//  ConfirmViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/17.
//

import Foundation
import Amplify
import Combine

class ConfirmViewModel {
    func confirmSignUp(for userData: [String], with confirmationCode: String, _ confirmSignUpHandler: @escaping (Bool) -> ()) {
        let userInfo = UserInfo(userData)
        Amplify.Auth.confirmSignUp(for: userInfo.phoneNumber, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
                confirmSignUpHandler(true)
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
                confirmSignUpHandler(false)
            }
        }
    }
    
    func makeUser(for userData: [String], _ makeUserHandler: @escaping (Bool) -> ()) {
        let userInfo = UserInfo(userData)
        let user = User(name: userInfo.name, phoneNumber: userInfo.phoneNumber, sex: userInfo.sex, born: userInfo.born)
//        UserDefaults.standard.set(user, forKey: "user")
//        print(UserDefaults.standard.object(forKey: "user"))
        Amplify.DataStore.save(user) {
            switch $0 {
            case .success:
                print("Created a new user successfully")
                DispatchQueue.main.async {
                    makeUserHandler(true)
                }
            case .failure(let error):
                print("Error creating user - \(error.localizedDescription)")
                DispatchQueue.main.async {
                    makeUserHandler(false)
                }
            }
        }
    }
    
    func resendSignUp(for userData: [String], _ resendSignUpHandler: @escaping (Bool) -> ()) {
        let userInfo = UserInfo(userData)
        Amplify.Auth.resendSignUpCode(for: userInfo.phoneNumber) { result in
            switch result {
            case .success:
                print("Resend signUp succeeded")
                DispatchQueue.main.async {
                    resendSignUpHandler(true)
                }
            case .failure(let error):
                print("An error occurred while resending sign up \(error)")
                DispatchQueue.main.async {
                    resendSignUpHandler(false)
                }
            }
        }
    }
}
