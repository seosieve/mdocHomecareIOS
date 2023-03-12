//
//  SettingViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class SettingViewController: UIViewController {

    let settingViewModel = SettingViewModel()
    
    let settingCellHeight: CGFloat = 50
    let sectionHeader = ["일반", "정보", ""]
    
    var statusBarView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var topContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var midContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var bottomContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var settingTableView = UITableView().then {
        $0.backgroundColor = .clear
        $0.separatorStyle = .none
        $0.sectionHeaderTopPadding = 0.0
        $0.isScrollEnabled = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I10
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        
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
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top)
        }
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(settingCellHeight*2+35)
        }
        midContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(16)
            make.left.centerX.equalToSuperview()
            make.height.equalTo(settingCellHeight*3+35)
        }
        bottomContainerView.snp.makeConstraints { make in
            make.top.equalTo(midContainerView.snp.bottom).offset(16)
            make.left.centerX.bottom.equalToSuperview()
        }
        
        view.addSubview(settingTableView)
        settingTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(settingCellHeight*7+200)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 1 ? 3 : 2
    }
    
    //header
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 2 ? 0 : 33
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel(frame: CGRect(x: 24, y: 16, width: 30, height: 17))
        headerLabel.text = sectionHeader[section]
        headerLabel.textColor = Colors.Text.subContent
        headerLabel.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    //footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        return footerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return settingCellHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingTableViewCell", for: indexPath) as! SettingTableViewCell
        cell.selectionStyle = .none
        let setting = Setting(indexPath.section, indexPath.row)
        cell.settingImageView.image = setting.image
        cell.settingTitleLabel.text = setting.title
        cell.settingTitleLabel.textColor = setting.color
        cell.divider.isHidden = setting.divider
        switch setting.type {
        case 1:
            cell.goToDetailImageView.isHidden = true
            cell.notiSwitch.isHidden = false
        case 2:
            cell.goToDetailImageView.isHidden = true
            cell.versionLabel.isHidden = false
        default:
            cell.goToDetailImageView.isHidden = false
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //서비스 이용약관
        if indexPath == [1,0] {
            let vc = PolicyViewController()
            vc.navigationItem.title = "서비스 이용약관"
            vc.policyTextView.text = Policy[0]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //개인정보 보호 정책
        if indexPath == [1,1] {
            let vc = PolicyViewController()
            vc.navigationItem.title = "개인정보 보호 정책"
            vc.policyTextView.text = Policy[1]
            self.navigationController?.pushViewController(vc, animated: true)
        }
        //로그아웃
        if indexPath == [2,0] {
            let alart = UIAlertController(title: "로그아웃 하시겠습니까?", message: "", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            cancel.setValue(Colors.Text.subContent, forKey: "titleTextColor")
            alart.addAction(cancel)
            alart.addAction(UIAlertAction(title: "로그아웃", style: .destructive) { action in
                self.settingViewModel.signOut { success in
                    if success {
                        let startViewController = StartViewController()
                        let vc = UINavigationController(rootViewController: startViewController)
                        window.rootViewController = vc
                        window.makeKeyAndVisible()
                    } else {
                        let alart = UIAlertController(title: "로그아웃이 정상적으로 이루어지지 않았습니다", message: "다시 한 번 시도해주세요", preferredStyle: .alert)
                        alart.addAction(UIAlertAction(title: "취소", style: .cancel))
                        self.present(alart, animated: true)
                    }
                }
            })
            self.present(alart, animated: true)
        }
        //서비스 탈퇴
        if indexPath == [2,1] {
            let alart = UIAlertController(title: "정말 서비스를 탈퇴하시겠습니까?", message: "회원 정보가 모두 삭제되며, 복구되지 않습니다", preferredStyle: .alert)
            let cancel = UIAlertAction(title: "취소", style: .cancel)
            cancel.setValue(Colors.Text.subContent, forKey: "titleTextColor")
            alart.addAction(cancel)
            alart.addAction(UIAlertAction(title: "서비스 탈퇴", style: .destructive) { action in
                self.settingViewModel.withdraw { success in
                    if success {
                        
                    } else {
                        
                    }
                }
            })
            self.present(alart, animated: true)
        }
    }
}
