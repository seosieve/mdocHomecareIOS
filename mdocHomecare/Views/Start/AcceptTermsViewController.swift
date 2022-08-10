//
//  AcceptTermsViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/08.
//

import UIKit

class AcceptTermsViewController: UIViewController {
    
    let termStringArr = ["(필수) 엠닥홈케어 이용약관 동의", "(필수) 개인정보 수집 및 이용 동의", "(선택) 광고성 정보 수신 동의", "만 14세 이상 회원입니다."]
    
    var acceptTermsContainerView = UIView().then {
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
        $0.text = "약관 동의"
        $0.font = UIFont(font: FontFamily.SFProText.bold, size: 24)
        $0.textColor = Colors.Text.mainContent
    }
    
    var termTableView = UITableView().then {
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
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var continueButton = UIButton().then {
        $0.setTitle("동의하고 계속 진행", for: .normal)
        $0.titleLabel?.font = UIFont(font: FontFamily.SFProText.regular, size: 16)
        $0.setTitleColor(Colors.Layout.I0, for: .normal)
        $0.backgroundColor = Colors.Semantic.mdocBlue
        $0.addTarget(self, action: #selector(continueButtonPressed), for: .touchUpInside)
    }
    
    @objc func continueButtonPressed() {
        let alart = UIAlertController(title: "회원가입을 계속 진행하시려면 필수 약관을 동의해주세요", message: "", preferredStyle: .alert)
        alart.addAction(UIAlertAction(title: "OK", style: .cancel))
        present(alart, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        termTableView.delegate = self
        termTableView.dataSource = self
        termTableView.register(AcceptTermsTableViewCell.self, forCellReuseIdentifier: "acceptTermsTableViewCell")
        setViews()
    }
    
    func setViews() {
        self.view.addSubview(acceptTermsContainerView)
        acceptTermsContainerView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(50)
            make.centerX.left.equalToSuperview()
            make.height.equalTo(400)
        }
        
        acceptTermsContainerView.addSubview(mdocLogo)
        acceptTermsContainerView.addSubview(subLabel)
        acceptTermsContainerView.addSubview(mainLabel)
        acceptTermsContainerView.addSubview(termTableView)
        acceptTermsContainerView.addSubview(goToLoginButton)
        acceptTermsContainerView.addSubview(continueButton)
        
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
        
        termTableView.snp.makeConstraints { make in
            make.top.equalTo(mainLabel.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.height.equalTo(208)
            make.left.equalToSuperview().offset(16)
        }
        
        goToLoginButton.snp.makeConstraints { make in
            make.top.equalTo(termTableView.snp.bottom).offset(4)
            make.height.equalTo(44)
            make.left.equalToSuperview().offset(16)
        }
        goToLoginButton.setUnderline()
        
        continueButton.snp.makeConstraints { make in
            make.top.equalTo(termTableView.snp.bottom).offset(4)
            make.height.equalTo(44)
            make.width.equalTo(150)
            make.right.equalToSuperview().inset(16)
        }
        continueButton.rounded()
    }
}

//MARK: - UITableView
extension AcceptTermsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "acceptTermsTableViewCell", for: indexPath) as! AcceptTermsTableViewCell
        cell.selectionStyle = .none
        if indexPath.row == 0 || indexPath.row == 1 {
            cell.showTermButton.isEnabled = true
        } else {
            cell.showTermButton.isEnabled = false
        }
        cell.termTitleButton.setTitle(termStringArr[indexPath.row], for: .normal)
        cell.termTitleButton.setColorRange("(필수)", UIColor.red)
        cell.showTermButtonAction = { [weak self] in
            let vc = TermDetailViewController()
            vc.index = indexPath.row
            vc.modalPresentationStyle = .automatic
            self!.present(vc, animated: true, completion: nil)
        }
        return cell
    }
    
}



