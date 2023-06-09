//
//  LoadingShowable.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 7.06.2023.
//

import UIKit

protocol LoadingShowable {
    func showLoading()
    func hideLoading()
}

extension LoadingShowable {
   
    func hideLoading() {
        LoadingView.shared.hideLoading()
    }
    
    func showLoading() {
        LoadingView.shared.startLoading()
    }
    
}

