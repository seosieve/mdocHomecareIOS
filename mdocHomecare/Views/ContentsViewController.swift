//
//  ContentsViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit
import UserNotifications

class ContentsViewController: UIViewController {

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
        self.view.backgroundColor = .white
        view.addSubview(notiButton)
        setViews()
    }
    
    @objc private func didTabButton() {
        print("aa")
        requestNotificationAuthorization()
        sendNotification(seconds: 2)
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
        //Notification Contents
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "LocalNoti"
        notificationContent.body = "LocalNotiTest"
        //Image Attach
        guard let imageURL = Bundle.main.url(forResource: "notImage", withExtension: ".jpeg") else { return }
        let attachment = try! UNNotificationAttachment(identifier: "notImage", url: imageURL, options: .none)
        notificationContent.attachments = [attachment]
        //Notification Trigger
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: seconds, repeats: false)
        //Binding,identifier(handling) -> Request
        let request = UNNotificationRequest(identifier: "testNotification", content: notificationContent, trigger: trigger)

        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
    }
}


