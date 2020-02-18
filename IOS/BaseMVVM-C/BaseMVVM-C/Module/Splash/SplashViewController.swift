//
//  SplashViewController.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

class SplashViewController: BaseViewController {
    weak var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.coordinator?.changeRootToMain()
        }
    }
}
