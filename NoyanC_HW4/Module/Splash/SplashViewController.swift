//
//  SplashViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Extensions

protocol SplashViewControllerProtocol: AnyObject {
    func noInternetConnection()
}

final class SplashViewController: UIViewController {
    var presenter: SplashPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        presenter.viewDidAppear()
    }
}

extension SplashViewController: SplashViewControllerProtocol {
    func noInternetConnection() {
        UIAlertController.alertMessage(title: AlertMessages.sorryTitle.rawValue,
                                       message: AlertMessages.noInternetMessage.rawValue,
                                       vc: self)
    }
}


