//
//  SettingViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit
import Then
import SnapKit
import Amplify
import AWSPluginsCore

class ViewMoreViewController: UIViewController {
    
    let userInfoCellHeight: CGFloat = 30
    let settingCellHeight: CGFloat = 50
    
    let viewModel = ViewMoreViewModel()
    
    var statusBarView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var topContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var userNameLabel = UILabel().then {
        $0.text = "홍길동"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 20)
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var userInfoTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.sectionFooterHeight = 36
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
        $0.isUserInteractionEnabled = false
    }
    
    var midContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var infoImageView = UIImageView().then {
        $0.image = Asset.SettingIcons.infoIcon.image
    }
    
    var infoLabel = UILabel().then {
        $0.numberOfLines = 0
        $0.text = "휴대 전화 번호는 변경이 불가능합니다.\n비상연락 혹은 비밀번호 초기화 용도로 사용됩니다"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 12)
        $0.textColor = Colors.Text.subContent
    }
    
    var bottomContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var settingTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Colors.Layout.I10
        self.navigationController?.navigationBar.isHidden = true
        
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(UserInfoTableViewCell.self, forCellReuseIdentifier: "userInfoTableViewCell")
        settingTableView.delegate = self
        settingTableView.dataSource = self
        settingTableView.register(SettingTableViewCell.self, forCellReuseIdentifier: "settingTableViewCell")
        setViews()
    }
    
    func setViews() {
        view.addSubview(statusBarView)
        view.addSubview(topContainerView)
        view.addSubview(midContainerView)
        view.addSubview(bottomContainerView)
        statusBarView.snp.makeConstraints { make in
            make.centerX.top.width.equalToSuperview()
            make.height.equalTo(window.safeAreaInsets.top)
        }
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(userInfoCellHeight*3+90)
        }
        midContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(20)
            make.left.centerX.equalToSuperview()
            make.height.equalTo(userInfoCellHeight+70)
        }
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(midContainerView.snp.bottom).offset(20)
            make.left.centerX.bottom.equalToSuperview()
        }
        
        topContainerView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(24)
            make.top.equalToSuperview().offset(40)
        }
        
        view.addSubview(userInfoTableView)
        userInfoTableView.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(18)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(userInfoCellHeight*4+36)
        }
        
        midContainerView.addSubview(infoImageView)
        midContainerView.addSubview(infoLabel)
        infoImageView.snp.makeConstraints { make in
            make.top.equalTo(userInfoTableView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(16)
        }
        infoLabel.snp.makeConstraints { make in
            make.left.equalTo(infoImageView.snp.right).offset(6)
            make.centerY.equalTo(infoImageView)
        }
        
        bottomContainerView.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(settingCellHeight*2+4)
        }
    }
}

extension ViewMoreViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        if tableView == userInfoTableView {
            return 2
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == userInfoTableView {
            return section == 0 ? 3 : 1
        } else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == userInfoTableView {
            return section == 0 ? 36 : 0
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == userInfoTableView {
            return userInfoCellHeight
        } else {
            return settingCellHeight
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == userInfoTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "userInfoTableViewCell", for: indexPath) as! UserInfoTableViewCell
            let viewMore = ViewMore(indexPath.section, indexPath.row, userData: "aa")
            
            cell.userInfoImageView.image = viewMore.image
            cell.userInfoTitleLabel.text = viewMore.title
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath) as! SettingTableViewCell
            cell.selectionStyle = .none
            if indexPath.row == 1 {
                cell.divider.alpha = 0
            }
            let postSetting = PostSetting(indexPath.row)
            cell.settingImageView.image = postSetting.image
            cell.settingTitleLabel.text = postSetting.title
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == settingTableView {
            var vc = UIViewController()
            if indexPath.row == 0 {
                vc = NotificationViewController()
                vc.navigationItem.title = "알림"
            } else {
                vc = SettingViewController()
                vc.navigationItem.title = "설정"
            }
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
