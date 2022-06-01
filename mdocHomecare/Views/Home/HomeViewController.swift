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
    var contentInset: UIEdgeInsets? = nil
    //LightMode 변경
    override var preferredStatusBarStyle: UIStatusBarStyle {
        .lightContent
    }
    
    lazy var scheduleTableView: UITableView = {
        let tableView = UITableView()
        tableView.contentInset = UIEdgeInsets(top: maxHeight, left: 0, bottom: 0, right: 0)
        return tableView
    }()
    
    var topSheetView = UIView().then {
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
    }
    
    var topSheetTextView = UIView().then {
        $0.backgroundColor = .green
    }
    
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
        $0.text = "입니다!"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 24)
        $0.textColor = Colors.Text.blueSubContent
    }
    
    var subLabel = UILabel().then {
        $0.text = "상담까지 34분 남았어요"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.textColor = Colors.Text.blueSubContent
    }
    
    var scheduleTitleLabel = UILabel().then {
        $0.text = "상담 일정"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    var enterChatButton = UIButton().then {
        $0.setTitle("상담방 입장", for: .normal)
    }
    
    var newReserveButton = UIButton().then {
        $0.setTitle("새 상담 예약", for: .normal)
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
        scheduleTableView.register(ScheduleTableViewCell.self, forCellReuseIdentifier: "ScheduleTableViewCell")
        setViews()
    }
    
    func setViews() {
        view.addSubview(scheduleTableView)
        scheduleTableView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        view.addSubview(topSheetView)
        topSheetView.addSubview(topSheetTextView)
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
        
//        scheduleTitleLabel.snp.makeConstraints { make in
//            make.left.equalToSuperview().offset(20)
//            make.top.equalTo(topSheetView.snp.bottom).offset(20)
//        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 25
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ScheduleTableViewCell", for: indexPath) as! ScheduleTableViewCell
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset.y)
        if scrollView.contentOffset.y < 0 {
            topSheetView.snp.updateConstraints { make in
//                make.height.equalTo(max(maxHeight - scrollView.contentOffset.y, minHeight))
                make.height.equalTo(max(abs(scrollView.contentOffset.y), minHeight))
            }
            scheduleTableView.contentInset = UIEdgeInsets(top: topSheetView.bounds.height, left: 0, bottom: 0, right: 0)
        } else {
            topSheetView.snp.updateConstraints { make in
                make.height.equalTo(minHeight)
            }
        }
    }
    
}
