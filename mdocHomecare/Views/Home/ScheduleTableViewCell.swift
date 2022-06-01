//
//  ScheduleTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/25.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {
    
    let dateLabel = UILabel().then {
        $0.text = "ddd"
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
        self.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
        }
    }
}
