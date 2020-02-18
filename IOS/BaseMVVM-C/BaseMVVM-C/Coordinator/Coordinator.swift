//
//  Coordinator.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

protocol Coordinator {
    var childCoordinator: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    func start()
}
