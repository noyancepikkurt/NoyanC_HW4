//
//  LoadingView.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

class LoadingView {
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var tableView: UITableView?
    static let shared = LoadingView()

    private init() {
        configure()
    }

    func configure() {
        activityIndicator.hidesWhenStopped = true
    }

    func startLoading(in tableView: UITableView) {
        self.tableView = tableView
        let blurEffect = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = tableView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.tag = 1234
        
        activityIndicator.center = tableView.center
        blurView.contentView.addSubview(activityIndicator)
        tableView.addSubview(blurView)
        
        activityIndicator.startAnimating()
    }

    func hideLoading() {
        DispatchQueue.main.async {
            self.activityIndicator.stopAnimating()
            
            if let tableView = self.tableView,
               let blurView = tableView.viewWithTag(1234) {
                blurView.removeFromSuperview()
            }
            
            self.tableView = nil
        }
    }
}

