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
        educationVideoView.snp.makeConstraints { make in
            make.height.equalTo(210)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview()
        }
        educationVideoView.load(withVideoId: "psL_5RIBqnY")
    }

}
