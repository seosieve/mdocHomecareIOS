//
//  StartViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/04.
//

import UIKit
import Amplify
import Combine
import UserNotifications

class StartViewController: UIViewController {

    let userNotificationCenter = UNUserNotificationCenter.current()
    
    lazy var notiButton: UIButton = {
        let button = UIButton()
        button.setTitle("LocalNoti", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.backgroundColor = .orange
        button.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let test = UILabel()
        view.backgroundColor = .white
        setViews()
        requestNotificationAuthorization()
        sendNotification(seconds: 6)
    }
    
    @objc private func didTabButton() {
        print("touch")
        let vc = DetailViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func setViews() {
        view.addSubview(notiButton)
        notiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        notiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
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

