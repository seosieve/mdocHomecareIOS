//
//  TermDetailViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/10.
//

import UIKit
import WebKit

class TermDetailViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    var index: Int?
    let urlString = ["https://m-doc.io/check/check/data/", "https://m-doc.io/check/check/agree"]
    
    var termDetailWebView = WKWebView()
    
    lazy var headerContainerView = UIView().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(headerTapped))
        $0.addGestureRecognizer(tapGesture)
    }
    
    @objc func headerTapped() {
        self.dismiss(animated: true)
    }
    
    var mdocLogo = UIImageView().then {
        $0.image = Asset.logoSquare.image
    }
    
    var cancelImageView = UIImageView().then {
        $0.image = Asset.Icons.cancelIcon.image
        $0.tintColor = Colors.Layout.I0
    }
    
    lazy var acceptTermButton = UIButton().then {
        $0.setTitle("이용약관 동의하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.addTarget(self, action: #selector(acceptTermButtonPressed), for: .touchUpInside)
    }
    
    @objc func acceptTermButtonPressed() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        termDetailWebView.uiDelegate = self
        termDetailWebView.navigationDelegate = self
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(termDetailWebView)
        self.view.addSubview(acceptTermButton)
        
        termDetailWebView.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(100)
            make.top.left.centerX.equalToSuperview()
        }
        
        let url = URL(string: urlString[index!])
        let request = URLRequest(url: url!)
        termDetailWebView.load(request)
        
        acceptTermButton.snp.makeConstraints { make in
            make.top.equalTo(termDetailWebView.snp.bottom).offset(20)
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(16)
        }
        acceptTermButton.rounded()
        
        self.view.addSubview(headerContainerView)
        
        headerContainerView.snp.makeConstraints { make in
            make.top.left.centerX.equalToSuperview()
            make.height.equalTo(56)
        }
        
        headerContainerView.addSubview(mdocLogo)
        headerContainerView.addSubview(cancelImageView)
        
        mdocLogo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
        }
        
        cancelImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(24)
            make.right.equalToSuperview().inset(16)
        }
    }
}
