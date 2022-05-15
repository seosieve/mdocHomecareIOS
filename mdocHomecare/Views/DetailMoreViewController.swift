//
//  DetailMoreViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit

class DetailMoreViewController: UIViewController {

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        let button = UIButton()
        view.addSubview(button)
        button.setTitle("LocalNoti", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .orange
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = button.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = button.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        
        let centerX = button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let centerY = button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        NSLayoutConstraint.activate([leading, trailing, centerX, centerY])
    }
}
