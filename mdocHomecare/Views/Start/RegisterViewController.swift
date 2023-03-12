//
//  RegisterViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/08.
//

import UIKit
import Amplify
import AWSPluginsCore


class RegisterViewController: UIViewController {
    
    let registerViewModel = RegisterViewModel()

    let registerStringArr = ["이름", "생년월일", "전화번호", "비밀번호"]
    let placeholderArr = ["ex. 홍길동", "ex. 971002", "ex. 010-1234-5678", "ex. ••••••••"]
    var userInfoArr = ["","","","","","male"]
    
    var registerContainerView = UIView().then {
        $0.backgroundColor = Colors.Layout.I0
    }
    
    var mdocLogo = UIImageView().then {
        $0.image = Asset.logoSquare.image
    }
    
    var subLabel = UILabel().then {
        $0.text = "환자•보호자"
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 20)
        $0.textColor = Colors.Text.subContent
    }
    
    var mainLabel = UILabel().then {
        $0.text = "환자•보호자 회원가입"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 24)
        $0.textColor = Colors.Text.mainContent
    }
    
    var registerTableView = UITableView().then {
        $0.separatorStyle = .none
        $0.isScrollEnabled = false
    }
    
    lazy var goToLoginButton = UIButton().then {
        $0.setTitle("로그인 화면으로 이동", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.bold, size: 14)
        $0.setTitleColor(Colors.Semantic.mdocBlue, for: .normal)
        $0.addTarget(self, action: #selector(goToLoginPressed), for: .touchUpInside)
    }
    
    @objc func goToLoginPressed() {
        guard let viewControllerStack = self.navigationController?.viewControllers else { return }
        for viewController in viewControllerStack {
            if let LoginViewController = viewController as? LoginViewController {
                self.navigationController?.popToViewController(LoginViewController, animated: true)
            }
        }
    }
    
    lazy var confirmButton = UIButton().then {
        $0.setTitle("인증하기", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.addTarget(self, action: #selector(confirmButtonPressed), for: .touchUpInside)
    }
    
    @objc func confirmButtonPressed() {
        //ConfirmVC 바로가기
//        let vc = ConfirmViewController()
//        vc.userInfoArr = userInfoArr
//        self.navigationController?.pushViewController(vc, animated: true)
        if userInfoArr[1] == "" {
            // 이름이 입력되지 않았을 때
            let alart = UIAlertController(title: "이름을 입력해주세요.", message: "", preferredStyle: .alert)
            alart.addAction(UIAlertAction(title: "OK", style: .cancel))
            present(alart, animated: true)
        } else {
            if userInfoArr[2].count != 6 {
                // 생년월일이 입력되지 않았을 때
                let alart = UIAlertController(title: "생년월일을 올바르게 입력해주세요.", message: "예시. 971002", preferredStyle: .alert)
                alart.addAction(UIAlertAction(title: "OK", style: .cancel))
                present(alart, animated: true)
            } else {
                if userInfoArr[3] == "" || userInfoArr[3].count != 11 {
                    // 전화번호가 입력되지 않거나 올바르지 않을 때
                    let alart = UIAlertController(title: "올바른 전화번호를 입력해주세요.", message: "", preferredStyle: .alert)
                    alart.addAction(UIAlertAction(title: "OK", style: .cancel))
                    present(alart, animated: true)
                } else {
                    if userInfoArr[4].count < 8 {
                        // 비밀번호가 8자리 이하일 때
                        let alart = UIAlertController(title: "비밀번호는 최소 8자리 입니다.", message: "", preferredStyle: .alert)
                        alart.addAction(UIAlertAction(title: "OK", style: .cancel))
                        present(alart, animated: true)
                    } else {
                        registerViewModel.signUp(userInfoArr) { success in
                            if success {
                                // 성공
                                let vc = ConfirmViewController()
                                vc.userInfoArr = self.userInfoArr
                                self.navigationController?.pushViewController(vc, animated: true)
                            } else {
                                // 이미 같은 번호의 가입이 있을 때
                                let alart = UIAlertController(title: "같은 핸드폰 번호가 이미 존재합니다.", message: "", preferredStyle: .alert)
                                alart.addAction(UIAlertAction(title: "OK", style: .cancel))
                                self.present(alart, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    @objc func keyboardWillShow(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.registerContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(-100)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    @objc func keyboardWillHide(_ sender: Notification) {
        UIView.animate(withDuration: 10) {
            self.registerContainerView.snp.updateConstraints { make in
                make.centerY.equalToSuperview().offset(50)
            }
            self.view.layoutIfNeeded()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        registerTableView.delegate = self
        registerTableView.dataSource = self
        registerTableView.register(RegisterTableViewCell.self, forCellReuseIdentifier: "registerTableViewCell")
        self.hideKeyboardWhenTapped()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        setView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    func setView() {
        self.view.addSubview(registerContainerView)
        registerContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(400)
        }
        
        registerContainerView.addSubview(mdocLogo)
        registerContainerView.addSubview(subLabel)
        registerContainerView.addSubview(mainLabel)
        registerContainerView.addSubview(registerTableView)
        registerContainerView.addSubview(goToLoginButton)
        registerContainerView.addSubview(confirmButton)
        
        mdocLogo.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.height.width.equalTo(40)
            make.left.equalToSuperview().offset(16)
        }
        
        subLabel.snp.makeConstraints { make in
            make.centerY.equalTo(mdocLogo.snp.centerY)
            make.left.equalTo(mdocLogo.snp.right).offset(12)
        }
        
        mainLabel.snp.makeConstraints { make in
            make.top.equalTo(mdocLogo.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(16)
        }
        
        registerTableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(208)
            make.left.equalToSuperview().offset(16)
        }
        
        goToLoginButton.snp.makeConstraints { make in
            make.top.equalTo(registerTableView.snp.bottom).offset(4)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(16)
        }
        goToLoginButton.setUnderline()
        
        confirmButton.snp.makeConstraints { make in
            make.top.equalTo(registerTableView.snp.bottom).offset(4)
            make.height.equalTo(44)
            make.width.equalTo(91)
            make.right.equalToSuperview().inset(16)
        }
        confirmButton.rounded()
    }
}

extension RegisterViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return registerStringArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "registerTableViewCell", for: indexPath) as! RegisterTableViewCell
        cell.selectionStyle = .none
        cell.registerLabel.text = registerStringArr[indexPath.row]
        cell.registerTextField.attributedPlaceholder = NSAttributedString(string: placeholderArr[indexPath.row], attributes: [NSAttributedString.Key.foregroundColor : Colors.Default.gray4])
        if indexPath.row == 0 {
            
        } else if indexPath.row == 1 {
            cell.registerTextField.snp.updateConstraints { make in
                make.right.equalTo(cell.registerContainerView.snp.right).inset(128)}
            cell.maleCheckButton.isHidden = false
            cell.femaleCheckButton.isHidden = false
            cell.registerTextField.keyboardType = .numberPad
        } else if indexPath.row == 2 {
            cell.registerTextField.keyboardType = .numberPad
        } else {
            cell.registerTextField.isSecureTextEntry = true
        }
        cell.checkGenderAction = { [weak self
        ] gender in
            let genderInfo = gender ? "male" : "female"
            self?.userInfoArr[5] = genderInfo
            print(self?.userInfoArr ?? "")
        }
        cell.editTextFieldAction = { [weak self] text in
            self?.userInfoArr[indexPath.row+1] = text ?? ""
            print(self?.userInfoArr ?? "")
        }
        return cell
    }
}

