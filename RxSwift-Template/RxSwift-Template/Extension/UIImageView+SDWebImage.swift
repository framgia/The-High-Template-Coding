//
//  UIImageView+SDWebImage.swift
//  RxSwift-Template
//
//  Created by nguyen.the.trinh on 4/22/20.
//  Copyright © 2020 nguyen.the.trinh. All rights reserved.
//

extension UIImageView {
    func setImage(with url: URL?, completion: (() -> Void)? = nil) {
        self.backgroundColor = backgroundColor
        
        self.sd_setImage(with: url, placeholderImage: nil, options: .refreshCached) { (_, _, _, _) in
            completion?()
        }
    }
}
