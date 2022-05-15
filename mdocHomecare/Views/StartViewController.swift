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
    
    lazy var mdocLogo = UIImageView().then {
        $0.image = Asset.logoHc.image
    }
    
    lazy var backgroundImage = UIImageView().then {
        $0.image = Asset.startImg.image
    }
    
    lazy var mainLabel = UILabel().then {
        $0.text = "환자•보호자용"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 18)
        $0.textColor = Colors.Text.mainContent.withAlphaComponent(0.3)
    }
    
    lazy var subLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.text = "환자분의 건강관리를\n더욱 효과적으로 도와드리겠습니다"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var startButton = UIButton().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.setTitle("시작하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.titleLabel?.textColor = Colors.Layout.I0
        $0.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setViews()
    }
    
    @objc private func didTabButton() {
        print("touch")
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setViews() {
        self.view.addSubview(mdocLogo)
        mdocLogo.translatesAutoresizingMaskIntoConstraints = false
        mdocLogo.heightAnchor.constraint(equalToConstant: 96).isActive = true
        mdocLogo.widthAnchor.constraint(equalToConstant: 200).isActive = true
        mdocLogo.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mdocLogo.topAnchor.constraint(equalTo: view.topAnchor, constant: 60*UIScreen.main.bounds.width/100).isActive = true
    
        self.view.addSubview(backgroundImage)
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        backgroundImage.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        backgroundImage.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        self.view.addSubview(mainLabel)
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.topAnchor.constraint(equalTo: mdocLogo.bottomAnchor, constant: 25).isActive = true
        mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.view.addSubview(subLabel)
        subLabel.translatesAutoresizingMaskIntoConstraints = false
        subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 24).isActive = true
        subLabel.centerXAnchor.constraint(equalTo: mainLabel.centerXAnchor).isActive = true
        
        self.view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        startButton.rounded()
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
    
    func signUp(username: String, password: String, email: String) -> AnyCancellable {
        let userAttributes = [AuthUserAttribute(.email, value: email)]
        let options = AuthSignUpRequest.Options(userAttributes: userAttributes)
        let sink = Amplify.Auth.signUp(username: username, password: password, options: options)
            .resultPublisher
            .sink {
                if case let .failure(authError) = $0 {
                    print("An error occurred while registering a user \(authError)")
                }
            }
            receiveValue: { signUpResult in
                if case let .confirmUser(deliveryDetails, _) = signUpResult.nextStep {
                    print("Delivery details \(String(describing: deliveryDetails))")
                } else {
                    print("SignUp Complete")
                }

            }
        return sink
    }
}

