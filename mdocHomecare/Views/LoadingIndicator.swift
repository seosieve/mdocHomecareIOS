//
//  LoadingIndicator.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/15.
//

import UIKit

class LoadingIndicator {
    static func showLoading() {
        DispatchQueue.main.async {
            let loadingIndicatorView: UIActivityIndicatorView
            if let existedView = window.subviews.first(where: {$0 is UIActivityIndicatorView}) as? UIActivityIndicatorView {
                loadingIndicatorView = existedView
            } else {
                loadingIndicatorView = UIActivityIndicatorView(style: .large)
                loadingIndicatorView.frame = window.frame
                loadingIndicatorView.color = .brown
                window.addSubview(loadingIndicatorView)
            }
            loadingIndicatorView.startAnimating()
        }
    }
    
    static func hideLoading() {
        DispatchQueue.main.async {
            window.subviews.filter({$0 is UIActivityIndicatorView}).forEach{ $0.removeFromSuperview()}
        }
    }
}
