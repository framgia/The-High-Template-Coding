//
//  HomeCoordinator.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

protocol HomeCoordinatorProtocol: class {
    func passDataBack(text: String)
}

class HomeCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        
    }
    
    static func initVC() -> UIViewController {
        let navController = UINavigationController()
        let coordinator = HomeCoordinator(navigationController: navController)
        let homeVC = HomeViewController.instantiate(storyboard: Storyboard.Home.name)
        homeVC.coordinator = coordinator
        navController.viewControllers = [homeVC]
        return navController
    }
    
    func goToDemo(text: String, parent: UIViewController) {
        let vc = DemoViewController.instantiate(storyboard: Storyboard.Home.name)
        vc.coordinator = self
        //        vc.initData(text)
                vc.delegate = parent.self as? HomeCoordinatorProtocol
        navigationController.pushViewController(vc, animated: true)
    }
}
