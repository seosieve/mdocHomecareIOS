//
//  EducationViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit
import UserNotifications
import YoutubePlayer_in_WKWebView

class EducationViewController: UIViewController {

    let userNotificationCenter = UNUserNotificationCenter.current()
//    lazy var notiButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("LocalNoti", for: .normal)
//        button.setTitleColor(.blue, for: .normal)
//        button.backgroundColor = .orange
//        button.frame = CGRect(x: 100, y: 100, width: 200, height: 52)
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.addTarget(self, action: #selector(didTabButton), for: .touchUpInside)
//        return button
//    }()
    
    var youtubeView1 = WKYTPlayerView().then {
        $0.backgroundColor = .orange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    var youtubeView2 = WKYTPlayerView().then {
        $0.backgroundColor = .orange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    var youtubeView3 = WKYTPlayerView().then {
        $0.backgroundColor = .orange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setViews()
    }
    
//    @objc private func didTabButton() {
//        print("aa")
//        requestNotificationAuthorization()
//        sendNotification(seconds: 2)
//    }
    
    func setViews() {
//        view.addSubview(notiButton)
//        notiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        notiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addSubview(youtubeView1)
        view.addSubview(youtubeView2)
        view.addSubview(youtubeView3)
        
        youtubeView1.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().offset(120)
        }
        
        youtubeView2.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(youtubeView1.snp.bottom).offset(20)
        }
        
        youtubeView3.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.top.equalTo(youtubeView2.snp.bottom).offset(20)
        }
        
        
        youtubeView1.load(withVideoId: "psL_5RIBqnY")
        youtubeView2.load(withVideoId: "psL_5RIBqnY")
        youtubeView3.load(withVideoId: "psL_5RIBqnY")
        
        
        
        
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


