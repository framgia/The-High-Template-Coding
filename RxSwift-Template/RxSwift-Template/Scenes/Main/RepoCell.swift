//
//  MainViewController.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/6/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

import UIKit

final class RepoCell: UITableViewCell, NibReusable {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var avatarURLStringImageView: UIImageView!
    
    func bindViewModel(_ viewModel: RepoViewModel?) {
        if let viewModel = viewModel {
            nameLabel.text = viewModel.name
            avatarURLStringImageView.setImage(with: viewModel.url)
        } else {
            nameLabel.text = ""
            avatarURLStringImageView.image = nil
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        avatarURLStringImageView.image = nil
    }
}

