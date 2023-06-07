//
//  LoadingShowable.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

protocol LoadingShowable {
    func showLoading(in tableView: UITableView)
    func hideLoading()
}

extension LoadingShowable {
    func showLoading(in tableView: UITableView) {
        LoadingView.shared.startLoading(in: tableView)
    }

    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
}

