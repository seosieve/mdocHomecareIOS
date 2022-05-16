//
//  HomeViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {
    //LightMode 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    var statusBarView = UIView().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
    }
    
    var topSheetView = UIView().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    var scheduleScrollView = UIScrollView().then {
        $0.backgroundColor = .yellow
        $0.showsVerticalScrollIndicator = true
    }
    
    var contentView = UIView().then { _ in
    }
    
    var imageView = UIImageView().then {
        $0.image = Asset.startImg.image
    }
    var imageView2 = UIImageView().then {
        $0.image = Asset.startImg.image
    }
    var imageView3 = UIImageView().then {
        $0.image = Asset.startImg.image
    }
    
    var animationButton = UIButton().then {
        $0.setTitle("animation", for: .normal)
        $0.titleLabel?.tintColor = Colors.Semantic.mdocBlue
        $0.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        setViews()
    }
    
    func setViews() {
        view.addSubview(statusBarView)
        view.addSubview(topSheetView)
        
        statusBarView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(window.safeAreaInsets.top)
            make.top.equalToSuperview()
        }
        
        topSheetView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(228)
            make.top.equalTo(view.safeAreaLayoutGuide)
        }
        
        
        
        view.addSubview(scheduleScrollView)
        scheduleScrollView.snp.makeConstraints { make in
            make.top.equalTo(topSheetView.snp.bottom)
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        scheduleScrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scheduleScrollView.snp.top)
            make.leading.equalTo(scheduleScrollView.snp.leading)
            make.trailing.equalTo(scheduleScrollView.snp.trailing)
            make.bottom.equalTo(scheduleScrollView.snp.bottom)
            make.width.equalTo(scheduleScrollView.snp.width)
        }
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(50)
            make.trailing.equalTo(contentView.snp.trailing).offset(-50)
            make.bottom.equalTo(contentView.snp.bottom).offset(-20)
        }
        contentView.addSubview(imageView2)
        imageView2.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(50)
            make.trailing.equalTo(contentView.snp.trailing).offset(-50)
            make.height.equalTo(200)
        }
        contentView.addSubview(imageView3)
        imageView3.snp.makeConstraints { make in
            make.top.equalTo(imageView2.snp.bottom).offset(20)
            make.leading.equalTo(contentView.snp.leading).offset(50)
            make.trailing.equalTo(contentView.snp.trailing).offset(-50)
            make.height.equalTo(200)
        }
        
        
    }
    
    
    
}

