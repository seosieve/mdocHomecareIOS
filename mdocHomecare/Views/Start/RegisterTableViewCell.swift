//
//  RegisterTableViewCell.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/17.
//

import UIKit

class RegisterTableViewCell: UITableViewCell {
    
    var checkGenderAction: ((Bool) -> ())?
    var editTextFieldAction: ((String?) -> ())?
    
    var registerContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I10
        $0.layer.masksToBounds = true
        $0.layer.borderWidth = 1
        $0.layer.borderColor = Colors.Layout.I20.cgColor
        $0.layer.cornerRadius = 22
    }
    
    var registerLabel = UILabel().then {
        $0.text = "이름"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.textColor = Colors.Text.subContent
    }
    
    var registerTextField = UITextField().then {
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.attributedPlaceholder = NSAttributedString(string: "ex. 홍길동", attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        $0.textColor = Colors.Text.mainContent
    }
    
    lazy var maleCheckButton = UIButton().then {
        $0.setTitle("남", for: .normal)
        $0.setImage(Asset.Icons.checkIconOFF.image, for: .normal)
        $0.setImage(Asset.Icons.checkIconON.image, for: .selected)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 16)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.semanticContentAttribute = .forceLeftToRight
        $0.tintColor = Colors.Semantic.mdocBlue
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        $0.addTarget(self, action: #selector(genderChecked(_:)), for: .touchUpInside)
        $0.isSelected = true
        $0.isUserInteractionEnabled = false
        $0.isHidden = true
    }
    
    lazy var femaleCheckButton = UIButton().then {
        $0.setTitle("여", for: .normal)
        $0.setImage(Asset.Icons.checkIconOFF.image, for: .normal)
        $0.setImage(Asset.Icons.checkIconON.image, for: .selected)
        $0.imageView?.contentMode = .scaleAspectFit
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 16)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.contentHorizontalAlignment = .left
        $0.semanticContentAttribute = .forceLeftToRight
        $0.tintColor = Colors.Default.gray4
        $0.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        $0.addTarget(self, action: #selector(genderChecked(_:)), for: .touchUpInside)
        $0.isHidden = true
    }
    
    @objc func genderChecked(_ sender: UIButton) {
        sender == maleCheckButton ? maleChecked() : femaleChecked()
    }
    
    func maleChecked() {
        self.femaleCheckButton.isSelected = false
        self.femaleCheckButton.isUserInteractionEnabled = true
        self.maleCheckButton.isSelected = true
        self.maleCheckButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.femaleCheckButton.tintColor = Colors.Default.gray4
            self.maleCheckButton.tintColor = Colors.Semantic.mdocBlue
        }
        checkGenderAction?(true)
    }
    
    func femaleChecked() {
        self.maleCheckButton.isSelected = false
        self.maleCheckButton.isUserInteractionEnabled = true
        self.femaleCheckButton.isSelected = true
        self.femaleCheckButton.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.maleCheckButton.tintColor = Colors.Default.gray4
            self.femaleCheckButton.tintColor = Colors.Semantic.mdocBlue
        }
        checkGenderAction?(false)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        registerTextField.delegate = self
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
        contentView.addSubview(registerContainerView)
        
        registerContainerView.snp.makeConstraints { make in
            make.top.centerX.left.equalToSuperview()
            make.bottom.equalToSuperview().inset(8)
            make.height.equalTo(44)
        }
        
        registerContainerView.addSubview(registerLabel)
        registerContainerView.addSubview(registerTextField)
        registerContainerView.addSubview(maleCheckButton)
        registerContainerView.addSubview(femaleCheckButton)
        
        registerLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(16)
            make.width.equalTo(70)
        }
        
        registerTextField.snp.makeConstraints { make in
            make.centerY.height.equalToSuperview()
            make.left.equalTo(registerLabel.snp.right).offset(12)
            make.right.equalTo(registerContainerView.snp.right).inset(12)
            make.width.greaterThanOrEqualTo(200)
        }
        
        maleCheckButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(26)
            make.width.equalTo(50)
            make.right.equalTo(femaleCheckButton.snp.left)
        }
        
        femaleCheckButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(26)
            make.width.equalTo(50)
            make.right.equalToSuperview().inset(20)
        }
    }
}

//MARK: - UITextFieldDelegate
extension RegisterTableViewCell: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        editTextFieldAction?(textField.text)
    }
}
