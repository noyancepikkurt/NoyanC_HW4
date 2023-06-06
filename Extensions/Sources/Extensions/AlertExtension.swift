//
//  AlertExtension.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

extension UIAlertController {
    public static func alertMessage(title: String,
                             message: String,
                             vc: UIViewController
    ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
