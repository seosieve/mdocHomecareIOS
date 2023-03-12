//
//  UserInfoTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class UserInfoTableViewCell: UITableViewCell {

    var userInfoImageView = UIImageView().then {
        $0.image = Asset.SettingIcons.genderIcon.image
    }
    
    var userInfoTitleLabel = UILabel().then {
        $0.text = "성별"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.mainContent
    }
    
    var userInfo = UILabel().then {
        $0.text = "남성"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Default.gray2
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
        contentView.addSubview(userInfoImageView)
        contentView.addSubview(userInfoTitleLabel)
        contentView.addSubview(userInfo)
        userInfoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(24)
        }
        userInfoTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(userInfoImageView.snp.right).offset(6)
        }
        userInfo.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-24)
        }
    }

}
