//
//  LoginViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {
    
    var loginContainerView = UIView().then {
        $0.backgroundColor = .yellow
    }
    
    var mdocLogo = UIImageView().then {
        $0.image = Asset.logoSquare.image
    }
    
    var subLabel = UILabel().then {
        $0.text = "환자•보호자"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 20)
        $0.textColor = Colors.Text.subContent
    }
    
    var mainLabel = UILabel().then {
        $0.text = "환자•보호자 로그인"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 24)
        $0.textColor = Colors.Text.mainContent
    }
    
    var phoneNumberTextField = UITextField().then {
        $0.placeholder = "ex. 01012345678"
        $0.layer.borderWidth = 2
    }
    
    var passwordTextField = UITextField().then {
        $0.placeholder = "ex. ••••••••"
        $0.layer.borderWidth = 2
    }
    
    var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
    }
    
    var registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.backgroundColor = .red
    }
    
    var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.backgroundColor = .blue
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        loginContainerView.frame.origin.y = 0
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        loginContainerView.frame.origin.y = 0
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(loginContainerView)
        loginContainerView.snp.makeConstraints { make in
            make.centerY.centerX.left.equalToSuperview()
            make.height.equalTo(275)
        }
        
        loginContainerView.addSubview(mdocLogo)
        loginContainerView.addSubview(subLabel)
        loginContainerView.addSubview(mainLabel)
        loginContainerView.addSubview(phoneNumberTextField)
//        loginContainerView.addSubview(passwordTextField)
//        loginContainerView.addSubview(findPasswordButton)
//        loginContainerView.addSubview(registerButton)
//        loginContainerView.addSubview(startButton)
        
        mdocLogo.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mdocLogo.snp.centerY)
            make.left.equalTo(mdocLogo.snp.right).offset(12)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(mdocLogo.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
//            make.height.equalTo(30)
        }
//
//        passwordTextField.snp.makeConstraints { make in
//            make.top.equalTo(phoneNumberTextField.snp.bottom).offset(12)
//            make.centerX.equalToSuperview()
//            make.left.equalToSuperview().offset(16)
//            make.height.equalTo(30)
//        }
        
//        findPasswordButton.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.height.height.equalTo(44)
//            make.height.width.equalTo(150)
//            make.left.equalToSuperview().offset(16)
//        }
//
//        registerButton.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.height.height.equalTo(findPasswordButton.snp.height)
//            make.height.width.equalTo(91)
//            make.right.equalTo(registerButton.snp.left)
//        }
//
//        registerButton.snp.makeConstraints { make in
//            make.top.equalToSuperview()
//            make.height.width.equalTo(40)
//            make.right.equalToSuperview().offset(16)
//        }
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")") }
    
}
