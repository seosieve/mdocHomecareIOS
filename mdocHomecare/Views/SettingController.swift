//
//  SettingViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit
import Then
import SnapKit

class SettingViewController: UIViewController {
    
    var userInfoscrollView = UIScrollView().then {
        $0.backgroundColor = .red
    }
    
    var userInfoView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = Colors.Layout.I5
        
        setViews()
    }
    
    func setViews() {
        
        self.view.addSubview(userInfoscrollView)
        userInfoscrollView.snp.makeConstraints { make in
            make.top.equalTo(window.safeAreaInsets.top)
            make.width.equalToSuperview()
            make.height.equalTo(300)
        }
        userInfoscrollView.addSubview(userInfoView)
        
        
//        self.view.addSubview(userInfoView)
//        userInfoView.snp.makeConstraints { make in
//            make.width.equalToSuperview()
//            make.height.equalTo(179+window.safeAreaInsets.top)
//            make.top.equalToSuperview()
//        }
    }
}
