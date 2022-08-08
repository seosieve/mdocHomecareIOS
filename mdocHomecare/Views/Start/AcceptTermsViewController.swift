//
//  AcceptTermsViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/08/08.
//

import UIKit

class AcceptTermsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
    }

}
