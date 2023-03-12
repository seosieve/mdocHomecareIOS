//
//  AcceptTermsTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/10.
//

import UIKit

class AcceptTermsTableViewCell: UITableViewCell {
    
    var showTermButtonAction: (() -> ())?
    var checkTermAction: ((Bool) -> ())?
    
    var termContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I10
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.Layout.I20.cgColor
        $0.layer.cornerRadius = 22
    }
    
    lazy var checkButton = UIButton().then {
        $0.setImage(Asset.Icons.checkIconOFF.image, for: .normal)
        $0.setImage(Asset.Icons.checkIconON.image, for: .selected)
        $0.tintColor = Colors.Default.gray4
        $0.addTarget(self, action: #selector(termChecked), for: .touchUpInside)
    }
    
    @objc func termChecked() {
        if checkButton.isSelected {
            self.checkButton.isSelected = false
            UIView.animate(withDuration: 0.3) {
                self.checkButton.tintColor = Colors.Default.gray4
            }
        } else {
            self.checkButton.isSelected = true
            UIView.animate(withDuration: 0.3) {
                self.checkButton.tintColor = Colors.Semantic.mdocBlue
            }
        }
        checkTermAction?(checkButton.isSelected)
    }
    
    lazy var termTitleButton = UIButton(type: .system).then {
        $0.contentHorizontalAlignment = .left
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.setTitleColor(Colors.Text.mainContent, for: .normal)
        $0.addTarget(self, action: #selector(termChecked), for: .touchUpInside)
    }
    
    lazy var showTermButton = UIButton().then {
        $0.setImage(Asset.Icons.arrowIcon.image, for: .normal)
        $0.setImage(UIImage(), for: .disabled)
        $0.tintColor = Colors.Default.gray4
        $0.addTarget(self, action: #selector(showTermButtonPressed), for: .touchUpInside)
    }
    
    @objc func showTermButtonPressed() {
        showTermButtonAction?()
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
        contentView.backgroundColor = Colors.Layout.I0
        contentView.addSubview(termContainerView)
        
        termContainerView.snp.makeConstraints { make in
            make.top.centerX.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        termContainerView.addSubview(checkButton)
        termContainerView.addSubview(termTitleButton)
        termContainerView.addSubview(showTermButton)
        
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(26)
            make.left.equalToSuperview().offset(12)
        }

        termTitleButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(showTermButton.snp.left)
            make.height.equalToSuperview()
            make.left.equalTo(checkButton.snp.right).offset(20)
        }
        
        showTermButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.height.equalTo(24)
            make.right.equalToSuperview().inset(12)
        }
    }
}
