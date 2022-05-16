//
//  TabBarController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = Colors.Layout.I20.cgColor
        tabBar.tintColor = Colors.Semantic.mdocBlue
        tabBar.unselectedItemTintColor = Colors.Text.subContent
        tabBar.backgroundColor = Colors.Layout.I0
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let homeVC = ChangableNavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = Asset.TabBarImages.home.image
        homeVC.tabBarItem.title = "상담"
        homeVC.navigationBar.barStyle = .black
        
        let educationVC = UINavigationController(rootViewController: EducationViewController())
        educationVC.tabBarItem.image = Asset.TabBarImages.education.image
        educationVC.tabBarItem.title = "교육자료"
        
        let settingVC = UINavigationController(rootViewController: SettingViewController())
        settingVC.navigationItem.title = "ddddddal"
        settingVC.tabBarItem.image = Asset.TabBarImages.setting.image
        settingVC.tabBarItem.title = "더보기"
        
        setViewControllers([homeVC, educationVC, settingVC], animated: true)
    }
}

//MARK: - ChangableNavigationController
//view마다 statusBarMode다르게 적용하기 위해 상속
class ChangableNavigationController: UINavigationController {
    override var childForStatusBarStyle: UIViewController? { return visibleViewController}
}
