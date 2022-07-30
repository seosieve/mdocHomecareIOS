//
//  EducationViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit
import UserNotifications

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
    let maxHeight = 117 + window.safeAreaInsets.top
    let hashTagArr = ["전체", "#일반 사항", "#합병증", "#주제", "#어쩌구", "#저쩌구"]
    var selectedHashTagArr = ["전체"]
    
    var statusbarContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var educationTitleView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var educationTitleLabel = UILabel().then {
        $0.text = "교육자료"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 25)
        $0.textColor = Colors.Layout.I100
    }
    
    var hashTagView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var hashTagScrollView = UIScrollView().then {
        $0.showsHorizontalScrollIndicator = false
    }
    
    var contentView = UIView()
    
    var hashTagStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 8
    }
    
    var educationTableView = UITableView().then {
        $0.contentInset = UIEdgeInsets(top: 117, left: 0, bottom: 0, right: 0)
        $0.separatorStyle = .none
        $0.scrollIndicatorInsets = $0.contentInset
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        educationTableView.delegate = self
        educationTableView.dataSource = self
        educationTableView.register(EducationTableViewCell.self, forCellReuseIdentifier: "educationTableViewCell")
//        educationTableView.estimatedRowHeight = 1300
        setViews()
        educationTableView.rowHeight = UITableView.automaticDimension
    }
    
//    @objc private func didTabButton() {
//        print("aa")
//        requestNotificationAuthorization()
//        sendNotification(seconds: 2)
//    }
    
    @objc func hashTagSelected(_ sender: UIButton) {
        let index = Int(hashTagStackView.arrangedSubviews.firstIndex(of: sender)!)
        if index == 0 {
            if !sender.isSelected {
                for view in hashTagStackView.arrangedSubviews {
                    (view as! UIButton).isSelected = false
                }
                sender.isSelected = true
                selectedHashTagArr = ["전체"]
            }
        } else {
            if selectedHashTagArr.first == "전체" {
                (hashTagStackView.viewWithTag(1) as! UIButton).isSelected = false
                selectedHashTagArr.removeFirst()
                sender.isSelected = true
                selectedHashTagArr.append(hashTagArr[index])
            } else {
                if sender.isSelected {
                    sender.isSelected = false
                    let rm = selectedHashTagArr.firstIndex(of: hashTagArr[index])!
                    selectedHashTagArr.remove(at: rm)
                } else {
                    sender.isSelected = true
                    selectedHashTagArr.append(hashTagArr[index])
                }
            }
        }
        print(selectedHashTagArr)
    }
    
    func setViews() {
//        view.addSubview(notiButton)
//        notiButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        notiButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        view.addSubview(educationTableView)
        view.addSubview(statusbarContainerView)
        view.addSubview(educationTitleView)
        educationTitleView.addSubview(educationTitleLabel)
        view.addSubview(hashTagView)
        hashTagView.addSubview(hashTagScrollView)
        hashTagScrollView.addSubview(contentView)
        contentView.addSubview(hashTagStackView)
        
        educationTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        statusbarContainerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(window.safeAreaInsets.top + 20)
            make.width.equalTo(view.bounds.width)
            make.centerX.equalToSuperview()
        }
        
        educationTitleView.snp.makeConstraints { make in
            make.top.equalTo(window.safeAreaInsets.top + 20)
            make.height.equalTo(41)
            make.width.equalTo(view.bounds.width)
            make.centerX.equalToSuperview()
        }
        
        educationTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(24)
            make.bottom.equalToSuperview().inset(12)
        }
        
        hashTagView.snp.makeConstraints { make in
            make.top.equalTo(educationTitleView.snp.bottom)
            make.height.equalTo(56)
            make.width.equalTo(view.bounds.width)
            make.centerX.equalToSuperview()
        }
        
        hashTagScrollView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.equalTo(36)
            make.left.equalToSuperview().inset(24)
            make.centerX.equalToSuperview()
        }
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalToSuperview()
        }
        
        hashTagStackView.snp.makeConstraints { make in
            make.height.equalToSuperview()
            make.centerY.equalToSuperview()
            make.left.right.equalToSuperview()
        }
        
        for index in 0..<6 {
            lazy var hashTag = UIButton().then {
                $0.setBackgroundColor(Colors.Layout.I20, for: .normal)
                $0.setBackgroundColor(Colors.Semantic.mdocBlue, for: .selected)
                $0.setTitleColor(Colors.Default.gray1, for: .normal)
                $0.setTitleColor(Colors.Layout.I0, for: .selected)
                $0.setTitle(hashTagArr[index], for: .normal)
                $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
                $0.layer.masksToBounds = true
                $0.layer.cornerRadius = 18
                if index == 0 {
                    $0.tag = 1
                    $0.isSelected = true
                }
                $0.addTarget(self, action: #selector(hashTagSelected(_:)), for: .touchUpInside)
            }
            hashTag.snp.makeConstraints { make in
                make.width.equalTo(hashTag.intrinsicContentSize.width + 20)
            }
            hashTagStackView.addArrangedSubview(hashTag)
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

//MARK: - UITableView
extension EducationViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "educationTableViewCell", for: indexPath) as! EducationTableViewCell
        cell.selectionStyle = .none
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let level = maxHeight+scrollView.contentOffset.y
        print(level)
        if level > 0 {
            educationTitleView.snp.updateConstraints { make in
                make.height.equalTo(max(41 - level,0))
            }
            educationTitleLabel.alpha = 1 - (level*0.04)
        } else {
            educationTitleView.snp.updateConstraints { make in
                make.height.equalTo(41)
            }
            educationTitleLabel.alpha = 1
        }
    }
}
