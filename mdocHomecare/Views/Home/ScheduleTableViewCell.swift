//
//  ScheduleTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/25.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel().then {
        $0.text = "17일"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    let timeLabel = UILabel().then {
        $0.text = "14:00"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    let stateLabel = UILabel().then {
        $0.text = "상담 완료"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Default.gray4
    }
    
    let detailImageView = UIImageView().then {
        $0.frame = CGRect(x: 0, y: 0, width: 16, height: 16)
        $0.image = Asset.Icons.scheduleDetail.image
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setViews() {
        self.backgroundColor = Colors.Default.gray7
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        self.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(dateLabel.snp.right).offset(21)
            make.centerY.equalToSuperview()
        }
        self.addSubview(detailImageView)
        detailImageView.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        self.addSubview(stateLabel)
        stateLabel.snp.makeConstraints { make in
            make.right.equalTo(detailImageView.snp.left).offset(-12)
            make.centerY.equalToSuperview()
        }
    }
}
