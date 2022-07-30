//
//  StartViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/04.
//

import UIKit
import Then
import SnapKit
import Amplify
import Combine
import UserNotifications

class StartViewController: UIViewController {

    let userNotificationCenter = UNUserNotificationCenter.current()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .darkContent
    }
    
    var mdocLogo = UIImageView().then {
        $0.image = Asset.logoHc.image
        $0.alpha = 0
    }
    
    var backgroundImage = UIImageView().then {
        $0.image = Asset.startImg.image
    }
    
    var mainLabel = UILabel().then {
        $0.text = "환자•보호자용"
        $0.alpha = 0
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 18)
        $0.textColor = Colors.Text.mainContent.withAlphaComponent(0.3)
    }
    
    var subLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.alpha = 0
        $0.text = "환자분의 건강관리를\n더욱 효과적으로 도와드리겠습니다"
        $0.addLineSpacing(5)
        $0.textAlignment = .center
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var startButton = UIButton().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.alpha = 0
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.titleLabel?.textColor = Colors.Layout.I0
        $0.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
    }
    
    @objc private func didTabButton() {
        let vc = LoginViewController()
        vc.navigationItem.backButtonTitle = " "
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        setViews()
        fadeInAnimation()
        signUp(username: "+8201022922044", password: "12345678", email: "royalcircle97@naver.com", phonenumber: "+8201022922044")
    }
    
    func setViews() {
        self.view.addSubview(mdocLogo)
        mdocLogo.snp.makeConstraints { make in
            make.height.equalTo(96)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            let width = UIScreen.main.bounds.width
            make.top.equalToSuperview().inset(width*0.6)
        }
    
        self.view.addSubview(backgroundImage)
        backgroundImage.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide)
        }
        
        self.view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(mdocLogo.snp.bottom).offset(25)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(subLabel)
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        self.view.addSubview(startButton)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(16)
            make.bottom.equalToSuperview().inset(48)
        }
        startButton.rounded()
    }
    
    func fadeInAnimation() {
        UIView.animateKeyframes(withDuration: 3, delay: 0) {
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1/4) {
                self.mdocLogo.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 2/4) {
                self.mainLabel.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 3/4) {
                self.subLabel.alpha = 1
            }
            UIView.addKeyframe(withRelativeStartTime: 1/3, relativeDuration: 1) {
                self.startButton.alpha = 1
            }
        }
    }
    
    //MARK: - Notification
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)

        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if let error = error {
                print("Error: \(error)")
            }
        }
    }
    
    func sendNotification(seconds: Double) {
        let notificationContent = UNMutableNotificationContent()

        notificationContent.title = "LocalNoti"
        notificationContent.body = "LocalNotiTest"

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        let request = UNNotificationRequest(identifier: "testNotification",
                                            content: notificationContent,
                                            trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
    
    //MARK: - AWS Auth
    func fetchCurrentAuthSession2() {
        _ = Amplify.Auth.fetchAuthSession { result in
            switch result {
            case .success(let session):
                print("Is user signed in - \(session.isSignedIn)")
            case .failure(let error):
                print("Fetch session failed with error \(error)")
            }
        }
    }
    
    func fetchCurrentAuthSession() -> AnyCancellable {
        Amplify.Auth.fetchAuthSession().resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("Fetch session failed with error \(authError)")
                }
            }
            receiveValue: { session in
                print("Is user signed in - \(session.isSignedIn)")
            }
    }
    
    func signUp(username: String, password: String, email: String, phonenumber: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email), AuthUserAttribute(.phoneNumber, value: phonenumber)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func signUp2(username: String, password: String, email: String) {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        Amplify.Auth.signUp(username: username, password: password, options: options) { result in
            switch result {
            case .success(let signUpResult):
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }
            case .failure(let error):
                print("An error occurred while registering a user \(error)")
            }
        }
    }
    
    func confirmSignUp(for username: String, with confirmationCode: String) {
        Amplify.Auth.confirmSignUp(for: username, confirmationCode: confirmationCode) { result in
            switch result {
            case .success:
                print("Confirm signUp succeeded")
            case .failure(let error):
                print("An error occurred while confirming sign up \(error)")
            }
        }
    }
}
