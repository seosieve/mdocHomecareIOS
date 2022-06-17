//
//  HomeViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit
import Then
import SnapKit

class HomeViewController: UIViewController {
    let maxHeight: CGFloat = 228 + window.safeAreaInsets.top
    let minHeight: CGFloat = 128 + window.safeAreaInsets.top
    
    let sectionHeader = ["2022년 8월", "2022년 9월", "2022년 10월"]
    //LightMode 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    var scheduleScrollView = UIScrollView().then {
        $0.contentInset = UIEdgeInsets(top: 228, left: 0, bottom: 0, right: 0)
        $0.scrollIndicatorInsets = $0.contentInset
    }
    
    var scheduleContentView = UIView()
    
    var scheduleMainLabel = UILabel().then {
        $0.text = "상담 일정"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
//frame: CGRect(x: 0, y: 0, width: 0, height: 0), style: .insetGrouped
    var scheduleTableView = UITableView().then {
        $0.backgroundColor = Colors.Layout.I0
        $0.isScrollEnabled = false
    }
    
    var topSheetView = UIView().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    var topSheetTextView = UIView()
    
    var nameLabel = UILabel().then {
        $0.text = "길동님, 예정된 상담 시간은"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 20)
        $0.textColor = Colors.Text.blueSubContent
    }
    
    var mainLabel = UILabel().then {
        $0.text = "7월 31일 오후 5시"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 24)
        $0.textColor = Colors.Layout.I0
    }
    
    var mainSideLabel = UILabel().then {
        $0.text = " 입니다!"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 24)
        $0.textColor = Colors.Text.blueSubContent
    }
    
    var subLabel = UILabel().then {
        $0.text = "상담까지 34분 남았어요"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.blueSubContent
    }
    
    var scheduleTitleLabel = UILabel().then {
        $0.text = "상담 일정"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    var buttonStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.distribution = .fillEqually
    }
    
    var enterChatButton = UIButton().then {
        $0.setTitle("상담방 입장", for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlueRenew
        $0.titleLabel?.textColor = Colors.Layout.I0
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.layer.cornerRadius = 8
    }
    
    var newReserveButton = UIButton().then {
        $0.setTitle("새 상담 예약", for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlueRenew
        $0.titleLabel?.textColor = Colors.Layout.I0
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.layer.cornerRadius = 8
    }
    
    var animationButton = UIButton().then {
        $0.setTitle("animation", for: .normal)
        $0.titleLabel?.tintColor = Colors.Semantic.mdocBlue
        $0.backgroundColor = .red
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        self.view.backgroundColor = .white
        scheduleTableView.delegate = self
        scheduleTableView.dataSource = self
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "scheduleTableViewCell")
        scheduleTableView.separatorColor = UIColor.clear
        scheduleScrollView.delegate = self
        setViews()
    }
    
    func setViews() {
        view.addSubview(scheduleScrollView)
        scheduleScrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scheduleScrollView.addSubview(scheduleContentView)
        scheduleContentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        scheduleContentView.addSubview(scheduleMainLabel)
        scheduleMainLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(20)
            make.left.equalToSuperview().inset(20)
        }
        
        scheduleContentView.addSubview(scheduleTableView)
        scheduleTableView.snp.makeConstraints { make in
            make.top.equalTo(scheduleMainLabel.snp.bottom).offset(4)
            make.height.equalTo(1200)
            make.bottom.equalToSuperview()
            make.left.right.equalToSuperview().inset(20)
        }
        
        view.addSubview(topSheetView)
        topSheetView.addSubview(topSheetTextView)
        topSheetView.addSubview(buttonStackView)
        buttonStackView.addArrangedSubview(enterChatButton)
        buttonStackView.addArrangedSubview(newReserveButton)
        topSheetTextView.addSubview(nameLabel)
        topSheetTextView.addSubview(mainLabel)
        topSheetTextView.addSubview(mainSideLabel)
        topSheetTextView.addSubview(subLabel)
//        view.addSubview(scheduleTitleLabel)
        
        topSheetView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.width.equalToSuperview()
            make.height.equalTo(228 + window.safeAreaInsets.top)
        }
        
        topSheetTextView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40 + window.safeAreaInsets.top)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(100)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalToSuperview()
        }
        
        mainSideLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom)
            make.left.equalTo(mainLabel.snp.right)
        }
        
        subLabel.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(8)
            make.left.equalToSuperview()
        }
        
        buttonStackView.snp.makeConstraints { make in
            make.height.equalTo(48)
            make.left.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(20)
        }
        
//        scheduleTitleLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(topSheetView.snp.bottom).offset(20)
//        }
    }
}

//MARK: - UITableView
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionHeader[section]
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        let headerLabel = UILabel(frame: CGRect(x: 0, y: -3, width: 90, height: 17))
        headerLabel.text = sectionHeader[section]
        headerLabel.textColor = Colors.Default.gray4
        headerLabel.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        headerView.addSubview(headerLabel)
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "scheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        
        //make separator
        let separator = CALayer()
        separator.frame = CGRect(x: 20.0, y: 48.0, width: cell.contentView.frame.size.width, height: 1.0)
        separator.backgroundColor = Colors.Default.gray6.cgColor
        cell.contentView.layer.addSublayer(separator)
        
        //rounded corner
        if indexPath.row == 0 {
            cell.layer.cornerRadius = 8
            cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }
        if indexPath.row == tableView.numberOfRows(inSection: indexPath.section) - 1 {
            cell.layer.cornerRadius = 8
            cell.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            separator.removeFromSuperlayer()
        }
        return cell
    }
}

//MARK: - UIScrollView
extension HomeViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let level = maxHeight + scrollView.contentOffset.y
        print(level)
        if scrollView.contentOffset.y > -maxHeight {
            topSheetView.snp.updateConstraints { make in
                make.height.equalTo(max(-scrollView.contentOffset.y, minHeight))
            }
            topSheetTextView.snp.updateConstraints { make in
                make.top.equalTo(max(40 + window.safeAreaInsets.top - (level), 10))
            }
            nameLabel.alpha = 1 - level*0.03
            mainLabel.alpha = 1 - level*0.015
            mainSideLabel.alpha = 1 - level*0.015
            
//            scheduleTableView.contentInset = UIEdgeInsets(top: topSheetView.bounds.height, left: 0, bottom: 0, right: 0)
        } else {
            topSheetView.snp.updateConstraints { make in
                make.height.equalTo(maxHeight)
            }
            topSheetTextView.snp.updateConstraints { make in
                make.top.equalTo(40 + window.safeAreaInsets.top)
            }
            nameLabel.alpha = 1
            mainLabel.alpha = 1
            mainSideLabel.alpha = 1
        }
    }
}
