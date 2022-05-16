//
//  Extensions.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/15.
//

import UIKit

let window: UIWindow = {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first ?? UIWindow()
    return window
}()

extension UIView {
    func rounded() {
        layoutIfNeeded()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
}



