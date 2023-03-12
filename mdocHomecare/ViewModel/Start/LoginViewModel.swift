//
//  LoginViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/17.
//

import Foundation
import Amplify

class LoginViewModel {
    func signIn(username: String, password: String, loginHandler: @escaping (Bool) -> ()) {
        Amplify.Auth.signIn(username: username, password: password) { result in
            switch result {
            case .success:
                print("Sign in succeeded")
                DispatchQueue.main.async {
                    loginHandler(true)
                }
            case .failure(let error):
                print("Sign in failed \(error)")
                DispatchQueue.main.async {
                    loginHandler(false)
                }
            }
        }
    }
}
