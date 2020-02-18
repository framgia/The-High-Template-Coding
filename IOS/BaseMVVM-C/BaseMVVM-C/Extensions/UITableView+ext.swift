//
//  UITableView+ext.swift
//  BaseMVVM-C
//
//  Created by Dung Khuat on 2/17/20.
//  Copyright © 2020 Dung Khuat. All rights reserved.
//

import UIKit

// MARK: TableViewCell
extension UITableViewCell {
    
    static func registerNibIn(_ tableView: UITableView) {
        let identifier = String(describing: self)
        tableView.register(UINib(nibName: identifier, bundle: nil), forCellReuseIdentifier: identifier)
    }
    
    static func dequeueReusableCellFrom<T: UITableViewCell>(_ tableView: UITableView, indexPath: IndexPath) -> T {
        let identifier = String(describing: self)
        if let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as? T {
            return cell
        }
        return T()
    }
    
}

extension UITableViewHeaderFooterView {
    
    static func registerHeaderFooterIn(_ tableView: UITableView) {
        let identifier = String(describing: self)
        tableView.register(UINib(nibName: identifier, bundle: nil), forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    static func dequeueReusableHeaderFooterFrom<T: UIView>(_ tableView: UITableView) -> T {
        let identifier = String(describing: self)
        if let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) as? T {
            return view
        }
        return T()
    }
}

extension UITableView {
    
    func showLoadMoreFooterView(_ completionHandler: @escaping () -> Void) {
        
        // create indicatorview
        let activityIndicatorView = UIActivityIndicatorView()
        activityIndicatorView.style = .gray
        
        // footerView
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: 50))
        footerView.addSubview(activityIndicatorView)
        activityIndicatorView.center = footerView.center
        footerView.backgroundColor = UIColor.clear
        
        // set to footerView
        self.tableFooterView = footerView
        
        // animating
        activityIndicatorView.startAnimating()
        
        // call back
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            completionHandler()
        }
    }
    
    func hideLoadMoreFooterView() {
        UIView.animate(withDuration: 0.3) {
            self.tableFooterView = nil
        }
    }
}

// MARK: - Pull to refresh
extension UITableView {
    func addPullToRefresh(vc: UIViewController, refreshControl: UIRefreshControl, triggerToMethodName: String) {
        refreshControl.attributedTitle = NSAttributedString(string: "")
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.addTarget(vc, action: Selector(triggerToMethodName), for: UIControl.Event.valueChanged)
        // Add Refresh Control to Table View
        if #available(iOS 10.0, *) {
            self.refreshControl = refreshControl
        } else {
            self.addSubview(refreshControl)
        }
    }
    
}
