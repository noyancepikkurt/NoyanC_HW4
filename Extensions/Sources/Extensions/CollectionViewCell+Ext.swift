//
//  CollectionViewCell+Ext.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

public extension UICollectionViewCell {
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
