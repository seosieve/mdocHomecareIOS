//
//  TabBarController.swift
//  mdocHomecare
//
//  Created by 서충원 on 2022/04/18.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = UIColor.green
        tabBar.tintColor = UIColor.purple
        tabBar.unselectedItemTintColor = UIColor.black
        setUpTabBar()
    }
    
    private func setUpTabBar() {
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        homeViewController.tabBarItem.image = UIImage(named: "home")
        homeViewController.tabBarItem.title = "상담"
        let contentsViewController = UINavigationController(rootViewController: ContentsViewController())
        contentsViewController.tabBarItem.image = UIImage(named: "contents")
        contentsViewController.tabBarItem.title = "일정"
        
        let detailMoreViewController = UINavigationController(rootViewController: DetailMoreViewController())
        detailMoreViewController.tabBarItem.image = UIImage(named: "detailMore")
        detailMoreViewController.tabBarItem.title = "더보기"
        
        setViewControllers([homeViewController, contentsViewController, detailMoreViewController], animated: true)
//        viewControllers =
    }
}
