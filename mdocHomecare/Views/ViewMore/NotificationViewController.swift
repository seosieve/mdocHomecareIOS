//
//  NotificationViewController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/09/28.
//

import UIKit

class NotificationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Colors.Layout.I0
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.tintColor = Colors.Text.mainContent
        self.navigationController?.navigationBar.topItem?.title = ""
    }

}
