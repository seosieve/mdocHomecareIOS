//
//  HomeViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit

class HomeViewController: UIViewController {
    
    var welcomeLabel: UILabel = {
        let label = UILabel(frame: CGRect(x:0, y:128, width: UIScreen.main.bounds.width, height: 60))
        label.text = "Welcome View 🇲🇱"
        label.font = UIFont(name: "SFPro-Black", size: 19)
        label.textColor = .green
        label.backgroundColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        view.addSubview(welcomeLabel)
        for sub in UIFont.fontNames(forFamilyName: "SF Pro") {
            print("====> \(sub)")
        }

        
    }
}

