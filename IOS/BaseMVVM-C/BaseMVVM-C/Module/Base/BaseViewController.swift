//
//  BaseViewController.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController, Storyboarded {

    lazy var mainTabBarViewController: TabBarViewController? = {
        if let tabBarController = self.tabBarController as? TabBarViewController {
            return tabBarController
        }
        
        return self.view.window?.rootViewController as? TabBarViewController
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func configNavBar() {
        let font = UIFont.helveticaNeueMeidum(size: 16)
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.hexStringToUIColor(hex: "#707070"), NSAttributedString.Key.font: font]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.shadowImage = UIImage.imageWithColor(color: #colorLiteral(red: 0.867574513, green: 0.8854880929, blue: 0.9046534896, alpha: 1))
        navigationController?.navigationBar.tintColor = UIColor.gray
        navigationController?.navigationBar.barTintColor = UIColor.white
    }
    
    private func setBackButtonArrow() {
        guard self != self.navigationController?.viewControllers.first else {
            return
        }
        let backButton = UIBarButtonItem(image: UIImage(named: "ic_arrow_back"),
                                         style: .plain,
                                         target: self,
                                         action: #selector(actionBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setBackButton(withTitle title: String) {
        guard self != self.navigationController?.viewControllers.first else {
            return
        }
        let backButton = UIBarButtonItem(title: title,
                                         style: .plain,
                                         target: self,
                                         action: #selector(actionBackButton))
        navigationItem.leftBarButtonItem = backButton
    }
    
    func setBackButtonWithArrow(andTitle title: String) {
        guard self != self.navigationController?.viewControllers.first else {
            return
        }
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "ic_arrow_back"), for: .normal)
        button.setTitle(" \(title)", for: .normal)
        button.sizeToFit()
        button.addTarget(self, action: #selector(actionBackButton), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
    }
    
    @objc func actionBackButton() {
        navigationController?.popViewController(animated: true)
    }
}
