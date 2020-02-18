//
//  DemoViewController.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

class DemoViewController: BaseViewController {
    weak var coordinator: HomeCoordinator?
    weak var delegate: HomeCoordinatorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction private func handleActionDone(_ sender: UIButton) {
        delegate?.passDataBack(text: "xxxxx")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
