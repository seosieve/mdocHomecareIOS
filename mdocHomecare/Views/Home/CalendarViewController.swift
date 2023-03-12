//
//  CalenderViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/21.
//

import UIKit
import SnapKit
import FSCalendar

class CalendarViewController: UIViewController {
    
    private var currentPage: Date?
    private lazy var today: Date = {
        return Date()
    }()
        
    private lazy var dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_KR")
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter
    }()
    
    var statusBarView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var topContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setImage(Asset.Icons.cancelIcon.image, for: .normal)
        $0.tintColor = Colors.Text.mainContent
        $0.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
    @objc func cancelButtonPressed() {
        self.dismiss(animated: true)
    }
    
    var titleLabel = UILabel().then {
        $0.text = "상담예약"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    var calendarContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 8
    }
    
    var calenerHeaderView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    lazy var headerLabel = UILabel().then {
        $0.text = self.dateFormatter.string(from: calendarView.currentPage)
        $0.font = UIFont(font: FontFamily.SFProText.medium, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var backwardButton = UIButton().then {
        var backwardImage = UIImage(cgImage: Asset.Icons.arrowIcon.image.cgImage!, scale: 1.0, orientation: .upMirrored)
        $0.setImage(backwardImage, for: .normal)
        $0.tintColor = Colors.Text.mainContent
        $0.addTarget(self, action: #selector(backwardButtonPressed), for: .touchUpInside)
    }
    
    lazy var forwardButton = UIButton().then {
        $0.setImage(Asset.Icons.arrowIcon.image, for: .normal)
        $0.tintColor = Colors.Text.mainContent
        $0.addTarget(self, action: #selector(forwardButtonPressed), for: .touchUpInside)
    }
    
    @objc func backwardButtonPressed() {
        scrollCurrentPage(true)
    }
    
    @objc func forwardButtonPressed() {
        scrollCurrentPage(false)
    }
    
    func scrollCurrentPage(_ reverse: Bool) {
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = reverse ? -1 : 1
        self.currentPage = calendar.date(byAdding: dateComponents, to: self.currentPage ?? self.today)
        self.calendarView.setCurrentPage(self.currentPage!, animated: true)
    }
    
    lazy var calendarView = FSCalendar().then {
        $0.scope = .month
        $0.headerHeight = 15
        $0.calendarHeaderView.isHidden = true
        $0.locale = Locale(identifier: "ko_KR")
        $0.appearance.weekdayFont = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.appearance.weekdayTextColor = Colors.Text.mainContent
        $0.appearance.titleFont = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.appearance.titleDefaultColor = Colors.Text.mainContent
        $0.appearance.titleWeekendColor = Colors.Text.subContent
        $0.appearance.titleTodayColor = Colors.Semantic.mdocBlue
        $0.appearance.todayColor = .clear
        $0.appearance.selectionColor = Colors.Semantic.mdocBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I10
        calendarView.delegate = self
        calendarView.dataSource = self
        setViews()
    }
    
    func setViews() {
        view.addSubview(statusBarView)
        view.addSubview(topContainerView)
        statusBarView.snp.makeConstraints { make in
            make.centerX.top.width.equalToSuperview()
            make.height.equalTo(window.safeAreaInsets.top)
        }
        topContainerView.snp.makeConstraints { make in
            make.top.equalTo(statusBarView.snp.bottom)
            make.centerX.width.equalToSuperview()
            make.height.equalTo(48)
        }
        
        topContainerView.addSubview(cancelButton)
        topContainerView.addSubview(titleLabel)
        cancelButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        view.addSubview(calendarContainerView)
        calendarContainerView.snp.makeConstraints { make in
            make.top.equalTo(topContainerView.snp.bottom).offset(20)
            make.left.equalToSuperview().inset(20)
            make.centerX.equalToSuperview()
            make.height.equalTo(calendarContainerView.snp.width).offset(100)
        }
        calendarContainerView.addSubview(calenerHeaderView)
        calenerHeaderView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.height.equalTo(54)
            make.left.equalToSuperview().inset(20)
        }
        calenerHeaderView.addSubview(headerLabel)
        calenerHeaderView.addSubview(backwardButton)
        calenerHeaderView.addSubview(forwardButton)
        headerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(10)
        }
        backwardButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalTo(forwardButton.snp.left).offset(-20)
        }
        forwardButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(10)
        }
        calendarContainerView.addSubview(calendarView)
        calendarView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(calenerHeaderView.snp.bottom)
            make.left.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(10)
        }
    }
}

extension CalendarViewController : FSCalendarDelegate, FSCalendarDataSource {
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let vc = TimeSelectViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        print(" 날짜가 선택되었습니다.")
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        self.headerLabel.text = self.dateFormatter.string(from: calendar.currentPage)
    }
}
