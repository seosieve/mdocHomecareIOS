//
//  ReservationModalViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class ReservationModalViewController: UIViewController {

    var modalContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
        $0.layer.cornerRadius = 20
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    var selectDayLabel = UILabel().then {
        $0.text = "2022년 12월 18일"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 20)
        $0.textColor = Colors.Semantic.mdocBlue
    }
    
    var selectTimeLabel = UILabel().then {
        $0.text = "14:00"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 20)
        $0.textColor = Colors.Semantic.mdocBlue
    }
    
    var divider = UIView().then {
        $0.backgroundColor = Colors.Layout.I20
    }
    
    var mainLabel = UILabel().then {
        $0.text = "선택하신 일정으로 정기 상담을 예약하시겠어요?"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var cancelButton = UIButton().then {
        $0.setTitle("취소", for: .normal)
        $0.backgroundColor = Colors.Layout.I10
        $0.setTitleColor(Colors.Text.mainContent, for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.medium, size: 15)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(cancelButtonPressed), for: .touchUpInside)
    }
    
    @objc func cancelButtonPressed() {
        // 위치값 조정으로 다시 고치기
        UIView.animate(withDuration: 0.5) {
            self.view.backgroundColor = .clear
        } completion: { _ in
            self.dismiss(animated: true)
        }
    }
    
    lazy var reservationButton = UIButton().then {
        $0.setTitle("상담 예약", for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.medium, size: 15)
        $0.layer.cornerRadius = 12
        $0.addTarget(self, action: #selector(reservationButtonPressed), for: .touchUpInside)
    }
    
    @objc func reservationButtonPressed() {
        self.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear
        setViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIView.animate(withDuration: 0.5, delay: 0.25) {
            self.view.backgroundColor = Colors.Layout.I100.withAlphaComponent(0.3)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        view.backgroundColor = .clear
    }
    
    func setViews() {
        view.addSubview(modalContainerView)
        modalContainerView.snp.makeConstraints { make in
            make.bottom.centerX.left.equalToSuperview()
            make.height.equalTo(window.safeAreaInsets.bottom+184)
        }
        
        modalContainerView.addSubview(selectDayLabel)
        modalContainerView.addSubview(selectTimeLabel)
        selectDayLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(24)
        }
        selectTimeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
        }
        
        modalContainerView.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.equalTo(selectDayLabel.snp.bottom).offset(16)
            make.height.equalTo(2)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
        
        modalContainerView.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        modalContainerView.addSubview(cancelButton)
        modalContainerView.addSubview(reservationButton)
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.width.equalTo((view.bounds.width - 56)/2)
            make.height.equalTo(48)
        }
        reservationButton.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(16)
            make.right.equalToSuperview().offset(-24)
            make.width.equalTo((view.bounds.width - 56)/2)
            make.height.equalTo(48)
        }
        
    }

}
