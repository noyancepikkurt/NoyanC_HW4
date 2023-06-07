//
//  HomeViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Extensions

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customizeBackgroundColor()
    }
    
    private func customizeBackgroundColor() {
        setGradientBackground(topColor: UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0),
                              bottomColor: UIColor(red: 0.5, green: 0.0, blue: 1.0, alpha: 1.0))
    }
    
    
}
