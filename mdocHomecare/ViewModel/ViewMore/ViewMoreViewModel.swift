//
//  ViewMoreViewModel.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/11/09.
//

import Foundation
import Amplify

class ViewMoreViewModel {
    func fetchUser(_ fetchUserHandler: @escaping (User) -> ()) {
        let id = UserDefaults.standard.string(forKey: "userId")!
        Amplify.DataStore.query(User.self, byId: id) {
            switch $0 {
            case .success(let result):
                if let user = result {
                    DispatchQueue.main.async {
                        fetchUserHandler(user)
                    }
                }
            case .failure(let error):
                print("Error on query() for type User - \(error.localizedDescription)")
            }
        }
    }
}
