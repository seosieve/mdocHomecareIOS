//
//  LoginViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit

class LoginViewController: UIViewController, UITextViewDelegate {
    
    var loginContainerView = UIView().then {
        $0.backgroundColor = .white
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
    
    var phoneNumberContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.Layout.I20.cgColor
    }
    
    var phoneNumberLabel = UILabel().then {
        $0.text = "휴대번호"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.subContent
    }
    
    var phoneNumberTextField = UITextField().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "ex. 01012345678", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
    }
    
    var passwordContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.Layout.I20.cgColor
    }
    
    var passwordLabel = UILabel().then {
        $0.text = "비밀번호"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.subContent
    }
    
    var passwordTextField = UITextField().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "ex. ••••••••", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
    }
    
    var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
    }
    
    lazy var registerButton = UIButton().then {
        $0.setTitle("회원가입", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue.withAlphaComponent(0.3), for: .disabled)
        $0.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
    }
    
    @objc private func registerButtonTapped() {
        if registerButton.isEnabled {
            registerButton.isEnabled = false
            print("aa")
        } else {
            registerButton.isEnabled = true
            print("bb")
        }
    }
    
    lazy var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue.withAlphaComponent(0.3), for: .disabled)
        $0.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
    }
    
    @objc private func startButtonTapped() {
        if startButton.isEnabled {
            startButton.isEnabled = false
            print("aa")
        } else {
            startButton.isEnabled = true
            print("bb")
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.loginContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.loginContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(50)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        phoneNumberTextField.delegate = self
        passwordTextField.delegate = self
        self.hideKeyboardWhenTapped()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(loginContainerView)
        loginContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(275)
        }
        
        loginContainerView.addSubview(mdocLogo)
        loginContainerView.addSubview(subLabel)
        loginContainerView.addSubview(mainLabel)
        loginContainerView.addSubview(phoneNumberContainerView)
        loginContainerView.addSubview(passwordContainerView)
        loginContainerView.addSubview(findPasswordButton)
        loginContainerView.addSubview(startButton)
        loginContainerView.addSubview(registerButton)
        
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
        //MARK: - phoneNumber
        phoneNumberContainerView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        
        phoneNumberContainerView.addSubview(phoneNumberLabel)
        phoneNumberContainerView.addSubview(phoneNumberTextField)
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(70)
        }
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.left.equalTo(phoneNumberLabel.snp.right).offset(12)
            make.right.equalTo(phoneNumberContainerView.snp.right).inset(12)
            make.width.greaterThanOrEqualTo(200)
        }
        phoneNumberContainerView.rounded()
        //MARK: - password
        passwordContainerView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberContainerView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        
        passwordContainerView.addSubview(passwordLabel)
        passwordContainerView.addSubview(passwordTextField)
        
        passwordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(70)
        }
        
        passwordTextField.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.left.equalTo(passwordLabel.snp.right).offset(12)
            make.right.equalTo(passwordContainerView.snp.right).inset(12)
        }
        passwordContainerView.rounded()
        
        
        findPasswordButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(12)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(16)
        }
        findPasswordButton.setUnderline()

        startButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(12)
            make.height.equalTo(44)
            make.width.equalTo(91)
            make.right.equalToSuperview().inset(16)
        }
        startButton.rounded()
        
        registerButton.snp.makeConstraints { make in
            make.top.equalTo(passwordContainerView.snp.bottom).offset(12)
            make.height.equalTo(44)
            make.width.equalTo(91)
            make.right.equalTo(startButton.snp.left).offset(-8)
        }
        registerButton.rounded()
        
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")") }
    
}
