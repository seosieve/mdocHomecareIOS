//
//  Extensions.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/05/15.
//

import UIKit

//MARK: - safeArea Detect
let window: UIWindow = {
    let scenes = UIApplication.shared.connectedScenes
    let windowScene = scenes.first as? UIWindowScene
    let window = windowScene?.windows.first ?? UIWindow()
    return window
}()

extension UIView {
    func rounded() {
        layoutIfNeeded()
        self.layer.masksToBounds = true
        self.layer.cornerRadius = self.frame.height/2
    }
}

extension UIButton {
    //MARK: - BackgroundColorForButtonState
    func setBackgroundColor(_ color: UIColor, for state: UIControl.State) {
        UIGraphicsBeginImageContext(CGSize(width: 1.0, height: 1.0))
        guard let context = UIGraphicsGetCurrentContext() else { return }
        context.setFillColor(color.cgColor)
        context.fill(CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0))
        let backgroundImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.setBackgroundImage(backgroundImage, for: state)
    }
    //MARK: - ButtonTextUnderLine
    func setUnderline() {
        guard let title = title(for: .normal) else { return }
        let attributedString = NSMutableAttributedString(string: title)
        attributedString.addAttributes([.underlineStyle: NSUnderlineStyle.single.rawValue], range: NSRange(location: 0, length: title.count))
        setAttributedTitle(attributedString, for: .normal)
    }
}

extension UILabel {
    //MARK: - LineSpacing
    func addLineSpacing(_ spacingValue: CGFloat = 2) {
        guard let textString = text else { return }
        let attributedString = NSMutableAttributedString(string: textString)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacingValue
        attributedString.addAttributes([.paragraphStyle: paragraphStyle], range: NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
}

//MARK: - KeyBoardDownWhenTouched
extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
