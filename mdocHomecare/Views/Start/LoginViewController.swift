//
//  LoginViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit
import Amplify

class LoginViewController: UIViewController {
    
    let loginViewModel = LoginViewModel()
    
    var loginContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var mdocLogo = UIImageView().then {
        $0.image = Asset.logoSquare.image
        $0.layer.shadowOffset = CGSize(width: 4, height: 4)
        $0.layer.shadowOpacity = 0.7
        $0.layer.shadowRadius = 2
        $0.layer.shadowColor = Colors.Default.gray4.cgColor
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
        $0.text = "전화번호"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.subContent
    }
    
    var phoneNumberTextField = UITextField().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "ex. 010-1234-5678", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
        $0.keyboardType = .numberPad
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
        $0.isSecureTextEntry = true
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "ex. ••••••••", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var findPasswordButton = UIButton().then {
        $0.setTitle("비밀번호를 잊으셨나요?", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.addTarget(self, action: #selector(findPasswordPressed), for: .touchUpInside)
    }
    
    @objc private func findPasswordPressed() {
        let vc = FindPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
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
        let vc = AcceptTermsViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var startButton = UIButton().then {
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.setBackgroundColor(Colors.Semantic.mdocBlue.withAlphaComponent(0.3), for: .disabled)
        $0.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
        $0.isEnabled = true
    }
    
    @objc private func startButtonTapped() {
        let phoneNumber = phoneNumberTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        if phoneNumber.count >= 8 && password.count >= 8 {
            loginViewModel.signIn(username: phoneNumber.makeGlobal(), password: password) { success in
                if success {
                    
                    
                    
                    
                    
                    
                    let vc = TabBarController()
                    window.rootViewController = vc
                    window.makeKeyAndVisible()
                } else {
                    let alart = UIAlertController(title: "비밀번호가 일치하지 않습니다", message: "비밀번호를 다시 확인해주세요", preferredStyle: .alert)
                    alart.addAction(UIAlertAction(title: "OK", style: .cancel))
                    self.present(alart, animated: true)
                }
            }
        } else {
            let alart = UIAlertController(title: "정확한 전화번호와 비밀번호를 입력해주세요", message: "", preferredStyle: .alert)
            alart.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alart, animated: true)
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
        self.hideKeyboardWhenTapped()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
//    func create() {
//        let user = User(name: "김덕배", sex: "남")
//        Amplify.DataStore.save(user) { result in
//            switch result {
//            case .success:
//                print("success")
//            case .failure:
//                print("fail")
//            }
//        }
//    }
//
//    var userArr = [User]()
//
//    func read() {
//        Amplify.DataStore.query(User.self) { result in
//            switch result {
//            case .success(let posts):
//                userArr = posts
//            case .failure(let error):
//                print("Error retrieving posts \(error)")
//            }
//        }
//    }
//
//    func update() {
//        var existingPost = userArr[0]
//
//        Amplify.DataStore.delete(existingPost) {
//            switch $0 {
//            case .success:
//                print("Deleted the existing post")
//            case .failure(let error):
//                print("Error updating post - \(error.localizedDescription)")
//            }
//        }
//    }
    
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
