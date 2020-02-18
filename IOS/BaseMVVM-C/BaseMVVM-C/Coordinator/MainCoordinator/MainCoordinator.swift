//
//  MainCoordinator.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

protocol MainCoordinatorProtocol: class {
    func passDataBack(text: String)
}

class MainCoordinator: Coordinator {
    var childCoordinator: [Coordinator] = []
    
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = SplashViewController.instantiate(storyboard: Storyboard.Main.name)
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }

    func changeRootToMain() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        appDelegate.window?.rootViewController = TabBarViewController()
        appDelegate.window?.makeKeyAndVisible()
    }
    
   
}
