//
//  TimeSelectCollectionViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class TimeSelectCollectionViewCell: UICollectionViewCell {
    var timeLabel = UILabel().then {
        $0.text = "14 : 00"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.mainContent
        $0.textAlignment = .center
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Not implemented required init?(coder: NSCoder)")
    }
    
    override var isSelected: Bool {
        didSet {
            if isSelected {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = Colors.Semantic.mdocBlue
                    self.timeLabel.textColor = Colors.Layout.I0
                }
            } else {
                UIView.animate(withDuration: 0.3) {
                    self.contentView.backgroundColor = Colors.Layout.I0
                    self.timeLabel.textColor = Colors.Text.mainContent
                }
            }
        }
    }
    
    func setViews() {
        contentView.backgroundColor = Colors.Layout.I0
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 8
        contentView.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.edges.equalTo(safeAreaLayoutGuide)
        }
    }
}
