//
//  FindPasswordViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/08.
//

import UIKit

class FindPasswordViewController: UIViewController {

    var findPasswordContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var findPasswordicon = UIImageView().then {
        $0.image = Asset.Icons.phoneCheckIcon.image
    }
    
    var mainLabel = UILabel().then {
        $0.text = "비밀번호 재설정"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 20)
        $0.textColor = Colors.Text.mainContent
    }
    
    var subLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "가입시 입력하신 이메일(휴대전화번호)를 인증해주세요\n인증 후 비밀번호를 재설정 하실 수 있습니다"
        $0.setLineSpacing(5)
        $0.textAlignment = .center
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.subContent
    }
    
    var certificationContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I10
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.Layout.I20.cgColor
    }
    
    var certificationTextField = UITextField().then {
        $0.textAlignment = .center
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "이메일(휴대전화번호)를 입력해주세요", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var sendCodeButton = UIButton().then {
        $0.setTitle("인증코드 보내기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.addTarget(self, action: #selector(sendCodeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func sendCodeButtonTapped() {
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.findPasswordContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.findPasswordContainerView.snp.updateConstraints { make in
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
        certificationTextField.delegate = self
        self.hideKeyboardWhenTapped()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(findPasswordContainerView)
        findPasswordContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(358)
        }
        
        findPasswordContainerView.addSubview(findPasswordicon)
        findPasswordContainerView.addSubview(mainLabel)
        findPasswordContainerView.addSubview(subLabel)
        findPasswordContainerView.addSubview(certificationContainerView)
        findPasswordContainerView.addSubview(sendCodeButton)
        
        findPasswordicon.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalTo(72)
            make.height.equalTo(100)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(findPasswordicon.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        certificationContainerView.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        certificationContainerView.rounded()
        
        certificationContainerView.addSubview(certificationTextField)
        
        certificationTextField.snp.makeConstraints { make in
            make.centerX.centerY.height.equalToSuperview()
        }
        
        sendCodeButton.snp.makeConstraints { make in
            make.top.equalTo(certificationContainerView.snp.bottom).offset(12)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(44)
        }
        sendCodeButton.rounded()
    }
}

//MARK: - UITextFieldDelegate
extension FindPasswordViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")")
    }
}
