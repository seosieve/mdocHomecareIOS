//
//  ConfirmViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/17.
//

import UIKit
import Amplify

class ConfirmViewController: UIViewController {
    
    let confirmViewModel = ConfirmViewModel()
    
    var limitTime = 180
    var userInfoArr = ["","","","","",""]

    var confirmToastMessageLabel = UILabel().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.text = "인증 코드가 전송되었습니다"
        $0.textAlignment = .center
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Layout.I0
        $0.alpha = 0
    }
    
    var limitTimeLabel = UILabel().then {
        $0.backgroundColor = Colors.Layout.I20
        $0.text = "3:00"
        $0.textAlignment = .center
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.textColor = Colors.Text.mainContent
        $0.alpha = 1
    }
    
    @objc func getSetTime() {
        secToTime(sec: limitTime)
        limitTime -= 1
    }
    
    func secToTime(sec: Int) {
        let minute = (sec % 3600) / 60
        let second = (sec % 3600) % 60
        
        if second < 10 {
            limitTimeLabel.text = String(minute) + ":" + "0" + String(second)
        } else {
            limitTimeLabel.text = String(minute) + ":" + String(second)
        }
        if limitTime != 0 {
            perform(#selector(getSetTime), with: nil, afterDelay: 1.0)
        }
    }
    
    var confirmContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var phoneImageView = UIImageView().then {
        $0.image = Asset.Icons.phoneIcon.image
    }
    
    var mainLabel = UILabel().then {
        $0.text = "문자를 확인해주세요"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 20)
        $0.textColor = Colors.Text.mainContent
    }
    
    var subLabel = UILabel().then {
        $0.text = "문자로 전송된 6자리 인증 코드를 입력하세요"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.subContent
    }
    
    lazy var phoneNumberLabel = UILabel().then {
        $0.text = userInfoArr[3]
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    var confirmNumberStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    var OTPView = OTPTextField().then {
        $0.tintColor = .clear
        $0.textColor = .clear
        $0.keyboardType = .numberPad
        $0.textContentType = .oneTimeCode
    }
    
    var progressStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 6
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    var activityIndicator = UIActivityIndicatorView().then {
        $0.color = Colors.Semantic.mdocBlue
        $0.hidesWhenStopped = true
        $0.stopAnimating()
    }
    
    var warningImageView = UIImageView().then {
        $0.image = Asset.Icons.warningIcon.image
        $0.contentMode = .scaleAspectFit
        $0.isHidden = true
    }
    
    var notiLabel = UILabel().then {
        $0.text = "문자 전송까지 약 30초 가량 소요될 수 있습니다"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.subContent.withAlphaComponent(0.7)
    }
    
    var resendStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .fill
        $0.distribution = .fill
    }
    
    var resendLabel = UILabel().then {
        $0.text = "코드를 못 받으셨나요?"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 12)
        $0.textColor = Colors.Text.subContent
    }
    
    lazy var resendButton = UIButton().then {
        $0.setTitle("인증 코드 재전송", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.addTarget(self, action: #selector(resendButtonTapped), for: .touchUpInside)
    }
    
    @objc private func resendButtonTapped() {
        confirmViewModel.resendSignUp(for: userInfoArr) { success in
            let alart = UIAlertController(title: "인증 코드가 재전송되었습니다", message: "재전송된 인증코드를 입력해주세요", preferredStyle: .alert)
            alart.addAction(UIAlertAction(title: "OK", style: .cancel))
            self.present(alart, animated: true)
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.confirmContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.confirmContainerView.snp.updateConstraints { make in
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        confirmToastAppearAnimation()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func confirmToastAppearAnimation() {
        confirmToastMessageLabel.transform = CGAffineTransform(translationX: 0, y: -100)
        UIView.animate(withDuration: 1.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, animations: {
            self.confirmToastMessageLabel.alpha = 1
            self.confirmToastMessageLabel.transform = CGAffineTransform.identity
        }) { _ in
            UIView.animate(withDuration: 1.5, delay: 3, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1) {
                self.confirmToastMessageLabel.snp.updateConstraints { make in
                    make.top.equalToSuperview().offset(-50)
                    self.confirmToastMessageLabel.alpha = 0
                }
                self.view.layoutIfNeeded()
            }
        }
    }
    
    func confirmDigitAnimation() {
        OTPView.didEnterLastDigit = { code in
            self.activityIndicator.startAnimating()
            self.warningImageView.isHidden = true
            self.notiLabel.text = "코드 확인중..."
            self.notiLabel.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
            self.notiLabel.textColor = Colors.Semantic.mdocBlue
            
            self.confirmViewModel.confirmSignUp(for: self.userInfoArr, with: code) { success in
                if success {
                    self.confirmViewModel.makeUser(for: self.userInfoArr) { success in
                        if success {
                            guard let viewControllerStack = self.navigationController?.viewControllers else { return }
                            for viewController in viewControllerStack {
                                if let LoginViewController = viewController as? LoginViewController {
                                    self.navigationController?.popToViewController(LoginViewController, animated: true)
                                }
                            }
                        }
                    }
                } else {
                    self.OTPView.OTPlabelArr[5].layer.removeAllAnimations()
                    self.OTPView.OTPlabelArr[5].layer.borderColor = Colors.Layout.I30.cgColor
                    self.OTPView.OTPlabelArr.forEach { label in
                        label.textColor = Colors.Semantic.warningRed
                    }
                    self.activityIndicator.stopAnimating()
                    self.warningImageView.isHidden = false
                    self.notiLabel.text = "유효하지 않은 코드입니다"
                    self.notiLabel.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
                    self.notiLabel.textColor = Colors.Semantic.warningRed
                    self.OTPView.shake()
                }
            }
        }
    }
    
    func setViews() {
        self.view.addSubview(confirmToastMessageLabel)
        confirmToastMessageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(55)
            make.centerX.equalToSuperview()
            make.height.equalTo(26)
            make.width.equalTo(182)
        }
        confirmToastMessageLabel.rounded()
        
        self.view.addSubview(limitTimeLabel)
        limitTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(52)
            make.right.equalToSuperview().offset(-16)
            make.height.equalTo(32)
            make.width.equalTo(67)
        }
        limitTimeLabel.rounded()
        getSetTime()
        
        self.view.addSubview(confirmContainerView)
        confirmContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(300)
        }
        
        confirmContainerView.addSubview(phoneImageView)
        confirmContainerView.addSubview(mainLabel)
        confirmContainerView.addSubview(subLabel)
        confirmContainerView.addSubview(phoneNumberLabel)
        confirmContainerView.addSubview(OTPView)
        confirmContainerView.addSubview(progressStackView)
        confirmContainerView.addSubview(notiLabel)
        confirmContainerView.addSubview(resendStackView)
        phoneImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.height.equalTo(48)
        }
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneImageView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(subLabel.snp.bottom).offset(6)
            make.centerX.equalToSuperview()
        }
        OTPView.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(40)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
        }
        confirmDigitAnimation()
        
        progressStackView.snp.makeConstraints { make in
            make.top.equalTo(OTPView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        progressStackView.addArrangedSubview(activityIndicator)
        progressStackView.addArrangedSubview(warningImageView)
        progressStackView.addArrangedSubview(notiLabel)
        
        resendStackView.addArrangedSubview(resendLabel)
        resendStackView.addArrangedSubview(resendButton)
        resendStackView.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
