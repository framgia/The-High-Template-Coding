//
//  TabBarController.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

enum Screen: Int {
    case feed, message, data, coin, myPage
}

class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTabBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // animate when appear
        UIView.animate(withDuration: 0.5) {
            self.view.alpha = 1.0
        }
    }
    
    func setupTabBar() {
        let navHome = HomeCoordinator.initVC()
        navHome.tabBarItem = UITabBarItem(title: "Home", image: nil, selectedImage: nil)
        let navSetting = UIStoryboard(name: "Setting", bundle: nil).instantiateInitialViewController()
        navSetting?.tabBarItem = UITabBarItem(title: "Setting", image: nil, selectedImage: nil)
        let listVC = [navHome, navSetting]
        viewControllers = listVC as? [UIViewController]
    }
    
    func hideTabbar(hide: Bool?, animated: Bool = false) {
        self.tabBar.isHidden = hide ?? false
    }
    
    func gotoTabWith(name screen: Screen) {
        self.selectedIndex = screen.rawValue
    }
}
