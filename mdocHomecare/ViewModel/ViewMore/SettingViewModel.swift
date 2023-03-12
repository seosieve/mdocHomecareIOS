//
//  SettingViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/10/25.
//

import Foundation
import Amplify

class SettingViewModel {
    func signOut(_ signOutHandler: @escaping (Bool) -> ()) {
        Amplify.Auth.signOut() { result in
            switch result {
            case .success:
                print("Successfully signed out")
                DispatchQueue.main.async {
                    signOutHandler(true)
                }
            case .failure(let error):
                print("Sign out failed with error \(error)")
                DispatchQueue.main.async {
                    signOutHandler(false)
                }
            }
        }
    }
    
    func withdraw(_ withdrawHandler: @escaping (Bool) -> ()) {
        Amplify.Auth.deleteUser() { result in
            switch result {
            case .success:
                print("Successfully deleted user")
                DispatchQueue.main.async {
                    withdrawHandler(true)
                }
            case .failure(let error):
                print("Delete user failed with error \(error)")
                DispatchQueue.main.async {
                    withdrawHandler(false)
                }
            }
        }
    }
    
    
    
}
