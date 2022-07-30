//
//  LoginViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/17.
//

import UIKit

class LoginViewController: UIViewController {

    lazy var textField: UITextField = {
        let width = 250
        let height = 60
        let posX: CGFloat = (self.view.bounds.width - CGFloat(width))/2
        let posY: CGFloat = (self.view.bounds.height - CGFloat(height))/2
        let textField = UITextField(frame: CGRect(x: posX, y: posY, width: 300, height: 20))
        
        textField.text = "dwadwadwa"
        textField.backgroundColor = .gray
        textField.delegate = self
        
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(textField)
    }
}

//MARK: - UITextFieldDelegate
extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) { print("textFieldDidBeginEditing: \((textField.text) ?? "Empty")") }
    
}
