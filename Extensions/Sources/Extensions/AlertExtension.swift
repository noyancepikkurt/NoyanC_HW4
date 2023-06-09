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
    
    public static func alertActionMessage(title: String, message: String, vc: UIViewController, completion: @escaping((Bool) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel) { _ in
            completion(false)
        }
        let alertAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { _ in
            completion(true)
        }
        alert.addAction(alertActionCancel)
        alert.addAction(alertAction)
        vc.present(alert, animated: true)
    }
}
