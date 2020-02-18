//
//  ViewController.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {
    var coordinator: HomeCoordinator?
    fileprivate let viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.doSomething()
    }

    @IBAction func handleActionGo(_ sender: UIButton) {
        coordinator?.goToDemo(text: "as", parent: self)
    }
}


extension HomeViewController: HomeCoordinatorProtocol {
    func passDataBack(text: String) {
        print("data: ", text)
    }
}
