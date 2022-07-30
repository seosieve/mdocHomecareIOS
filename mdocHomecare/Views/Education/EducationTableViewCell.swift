//
//  EducationTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/06/16.
//

import UIKit
import YoutubePlayer_in_WKWebView


class EducationTableViewCell: UITableViewCell {
    
    var educationVideoView = WKYTPlayerView().then {
        $0.backgroundColor = .orange
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 10
    }
    
    var playtimeLabel = UILabel().then {
        $0.backgroundColor = Colors.Layout.I100.withAlphaComponent(0.7)
        $0.textColor = Colors.Layout.I0
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 13)
        $0.textAlignment = .center
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 6
        $0.text = "00:00"
    }
    
    var titleLabel = UILabel().then {
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 20)
        $0.textColor = Colors.Layout.I100
        $0.text = "만선 신부전"
    }
    
    var subtitleLable = UILabel().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Layout.I100
        $0.numberOfLines = 0
        $0.text = "신장이 하는 일, 만성 dkamw;dka;wdkwakdakwdkwa신부전 개념"
    }
    
    var hashTagLable = UILabel().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 14)
        $0.textColor = Colors.Text.subContent
        $0.text = "#일반 사항"
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
        self.addSubview(educationVideoView)
        self.addSubview(playtimeLabel)
        self.addSubview(titleLabel)
        self.addSubview(subtitleLable)
        self.addSubview(hashTagLable)
        
        educationVideoView.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview()
        }
        
        playtimeLabel.snp.makeConstraints { make in
            make.width.equalTo(49)
            make.height.equalTo(28)
            make.right.equalTo(educationVideoView.snp.right).inset(12)
            make.bottom.equalTo(educationVideoView.snp.bottom).inset(12)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.left.equalTo(educationVideoView.snp.left)
            make.top.equalTo(educationVideoView.snp.bottom).offset(12)
        }
        
        subtitleLable.snp.makeConstraints { make in
            make.left.equalTo(educationVideoView.snp.left)
            make.centerX.equalToSuperview()
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
        }
        
        hashTagLable.snp.makeConstraints { make in
            make.left.equalTo(educationVideoView.snp.left)
            make.top.equalTo(subtitleLable.snp.bottom).offset(8)
            make.bottom.equalToSuperview().inset(24)
        }
        
        educationVideoView.load(withVideoId: "ldC6qoCfHRI")
    }

}
