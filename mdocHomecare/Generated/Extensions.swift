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

extension UIButton {
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
}



