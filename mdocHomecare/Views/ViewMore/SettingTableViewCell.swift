//
//  SettingTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    var settingImageView = UIImageView().then {
        $0.image = Asset.SettingIcons.notiIcon.image
    }
    
    var settingTitleLabel = UILabel().then {
        $0.text = "알림"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    var goToDetailImageView = UIImageView().then {
        $0.image = Asset.Icons.arrowIcon.image
        $0.tintColor = Colors.Text.subContent
    }
    
    var notiSwitch = SmallSwitch().then {
        $0.isHidden = true
        $0.onTintColor = Colors.Semantic.mdocBlue
    }
    
    var versionLabel = UILabel().then {
        $0.text = "1.3.21"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.subContent
        $0.isHidden = true
    }
    
    var divider = UIView().then {
        $0.backgroundColor = Colors.Layout.I20
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
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setViews() {
        contentView.addSubview(settingImageView)
        contentView.addSubview(settingTitleLabel)
        contentView.addSubview(goToDetailImageView)
        contentView.addSubview(notiSwitch)
        contentView.addSubview(versionLabel)
        contentView.addSubview(divider)
        settingImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(24)
        }
        settingTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(settingImageView.snp.right).offset(6)
        }
        goToDetailImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(20)
            make.right.equalToSuperview().offset(-24)
        }
        notiSwitch.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        versionLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
        divider.snp.makeConstraints { make in
            make.top.equalTo(settingTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(1.5)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
    }
}

//MARK: - SmallSwitch
@IBDesignable
class SmallSwitch: UISwitch {
    override func draw(_ rect: CGRect) {
        self.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
    }
    
}
