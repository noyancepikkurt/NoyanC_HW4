//
//  SplashPresenter.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import Foundation
import Reachability

protocol SplashPresenterProtocol: AnyObject {
    func viewDidAppear()
}

final class SplashPresenter: SplashPresenterProtocol {
 
    unowned var view: SplashViewControllerProtocol!
    let router: SplashRouterProtocol!
    let interactor: SplashInteractorProtocol!
    
    init(
         view: SplashViewControllerProtocol,
         router: SplashRouterProtocol,
         interactor: SplashInteractorProtocol
    ) {
        self.view = view
        self.router = router
        self.interactor = interactor
    }
    
    
    func viewDidAppear() {
        interactor.checkInternetConnection()
    }
    
}

extension SplashPresenter: SplashInteractorOutputProtocol {
    
    func internetConnection(status: Bool) {
        
        if status {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.router.navigate(.tabBar)
            }
        } else {
            view.noInternetConnection()
        }
    }
    
    
}

