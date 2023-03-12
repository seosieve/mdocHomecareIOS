//
//  TimeSelectViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/21.
//

import UIKit
import SnapKit

class TimeSelectViewController: UIViewController {

    let timeArr = ["08:30", "09:00", "09:30", "10:00", "10:30", "11:00", "11:30", "12:00", "12:30", "13:00", "13:30", "14:00", "14:30", "15:00", "15:30", "16:00", "16:30", "17:00"]
    
    var statusBarView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var topContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    lazy var backButton = UIButton().then {
        var backwardImage = UIImage(cgImage: Asset.Icons.arrowIcon.image.cgImage!, scale: 1.0, orientation: .upMirrored)
        $0.setImage(backwardImage, for: .normal)
        $0.tintColor = Colors.Text.mainContent
        $0.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true)
    }
    
    var titleLabel = UILabel().then {
        $0.text = "상담예약"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.mainContent
    }
    
    var scheduleIcon = UIImageView().then {
        $0.image = Asset.Icons.scheduleIcon.image
        $0.tintColor = Colors.Text.mainContent
    }
    
    var selectDayLabel = UILabel().then {
        $0.text = "2022년 12월 18일"
        $0.font = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    var divider = UIView().then {
        $0.backgroundColor = Colors.Layout.I20
    }
    
    var timeSelectLabel = UILabel().then {
        $0.text = "상담 시간 선택"
        $0.font = UIFont(font: FontFamily.SFProText.medium, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    var timeSelectCollectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
        var layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        $0.isScrollEnabled = true
        $0.showsVerticalScrollIndicator = false
        $0.collectionViewLayout = layout
        $0.backgroundColor = Colors.Layout.I10
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I10
        timeSelectCollectionView.delegate = self
        timeSelectCollectionView.dataSource = self
        timeSelectCollectionView.register(TimeSelectCollectionViewCell.self, forCellWithReuseIdentifier: "timeSelectCollectionViewCell")
        setView()
    }
    
    func setView() {
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
        
        topContainerView.addSubview(backButton)
        topContainerView.addSubview(titleLabel)
        backButton.snp.makeConstraints { make in
            make.height.width.equalTo(20)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(12)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.centerX.equalToSuperview()
        }
        
        view.addSubview(scheduleIcon)
        view.addSubview(selectDayLabel)
        scheduleIcon.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(topContainerView.snp.bottom).offset(21)
            make.left.equalToSuperview().offset(20)
        }
        selectDayLabel.snp.makeConstraints { make in
            make.left.equalTo(scheduleIcon.snp.right).offset(8)
            make.centerY.equalTo(scheduleIcon.snp.centerY)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.top.equalTo(selectDayLabel.snp.bottom).offset(19)
            make.height.equalTo(2)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(timeSelectLabel)
        timeSelectLabel.snp.makeConstraints { make in
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(timeSelectCollectionView)
        timeSelectCollectionView.snp.makeConstraints { make in
            make.top.equalTo(timeSelectLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(100)
        }
    }
}

extension TimeSelectViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return timeArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "timeSelectCollectionViewCell", for: indexPath) as! TimeSelectCollectionViewCell
        cell.timeLabel.text = timeArr[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing = 12
        let width = (Int(collectionView.bounds.width) - spacing)/2
        return CGSize(width: width, height: 42)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.cellForItem(at: indexPath)?.isSelected = true
        print(timeArr[indexPath.row])
        let vc = ReservationModalViewController()
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true)
    }
}
