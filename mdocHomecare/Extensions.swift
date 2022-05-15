//
//  Extensions.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/15.
//

import UIKit

extension UIView {
    func rounded() {
        layoutIfNeeded()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
}
