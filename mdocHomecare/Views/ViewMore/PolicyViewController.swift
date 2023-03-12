//
//  PolicyViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/11/09.
//

import UIKit

class PolicyViewController: UIViewController {

    var policyTextView = UITextView().then {
        $0.text = ""
        $0.font = UIFont(font: FontFamily.SFProText.regular, size: 12)
        $0.textColor = Colors.Default.gray2
        $0.scrollIndicatorInsets = $0.contentInset
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
        setViews()
    }
    
    func setViews() {
        view.addSubview(policyTextView)
        policyTextView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaInsets.top)
            make.bottom.equalTo(window.safeAreaInsets.bottom).offset(36)
            make.centerX.equalToSuperview()
            make.left.equalToSuperview().offset(24)
        }
    }

}
