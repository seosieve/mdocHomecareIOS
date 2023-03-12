//
//  RegisterViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/17.
//

import Foundation
import Amplify

class RegisterViewModel {
    func signUp(_ userData: [String], signUpHandler: @escaping (Bool)->()) {
        let userInfo = UserInfo(userData)
        let userAttributes = [AuthUserAttribute(.nickname, value: userInfo.born), AuthUserAttribute(.name, value: userInfo.name)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: userInfo.phoneNumber, password: userInfo.password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                    DispatchQueue.main.async {
                        signUpHandler(true)
                    }
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
                DispatchQueue.main.async {
                    signUpHandler(false)
                }
            }
        }
    }
}

