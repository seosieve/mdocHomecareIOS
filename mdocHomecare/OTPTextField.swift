//
//  OTPTextField.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/10/15.
//

import UIKit

class OTPTextField: UITextField {
    
    var didEnterLastDigit: ((String) -> ())?
    
    lazy var OTPlabelArr = [UILabel]()
    
    var OTPStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.spacing = 12
        $0.alignment = .fill
        $0.distribution = .fillEqually
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(becomeFirstResponder))
        delegate = self
        addGestureRecognizer(tapGestureRecognizer)
        addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        setViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @objc func textDidChange() {
        guard let text = self.text, text.count <= OTPlabelArr.count else { return }
        for i in 0..<OTPlabelArr.count {
            let currentLabel = OTPlabelArr[i]
            currentLabel.textColor = Colors.Semantic.mdocBlue
            if i < text.count {
                let index = text.index(text.startIndex, offsetBy: i)
                currentLabel.text = String(text[index])
                currentLabel.layer.borderColor = Colors.Semantic.mdocBlue.cgColor
                currenLabelAnimation(i)
                if i != 0 {
                    OTPlabelArr[i-1].layer.borderColor = Colors.Layout.I30.cgColor
                    OTPlabelArr[i-1].layer.removeAllAnimations()
                }
            } else {
                currentLabel.text?.removeAll()
                if i != 0 {
                    currentLabel.layer.borderColor = Colors.Layout.I30.cgColor
                    OTPlabelArr[i].layer.removeAllAnimations()
                }
            }
        }
        
        if text.count == OTPlabelArr.count {
            didEnterLastDigit?(text)
        }
    }
    
    func currenLabelAnimation(_ i: Int) {
        OTPlabelArr[i].transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        UIView.animate(withDuration: 0.5, delay: 0, options: [.repeat, .allowUserInteraction]) {
            self.OTPlabelArr[i].transform = CGAffineTransform.identity
        }
    }
    
    func setViews() {
        //arrange OTPStackView
        for i in 0...5 {
            let OTPLabel = UILabel().then {
                $0.textAlignment = .center
                $0.font = UIFont(font: FontFamily.SFProText.bold, size: 28)
                $0.textColor = Colors.Semantic.mdocBlue
                $0.layer.borderWidth = 2
                $0.layer.cornerRadius = 8
                if i == 0 {
                    $0.layer.borderColor = Colors.Semantic.mdocBlue.cgColor
                } else {
                    $0.layer.borderColor = Colors.Layout.I30.cgColor
                }
                $0.isUserInteractionEnabled = true
            }
            OTPStackView.addArrangedSubview(OTPLabel)
            OTPlabelArr.append(OTPLabel)
            currenLabelAnimation(0)
        }
        self.addSubview(OTPStackView)
        OTPStackView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
    }
}

extension OTPTextField: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let characterCount = textField.text?.count else { return false }
        return characterCount < OTPlabelArr.count || string == ""
    }
}
