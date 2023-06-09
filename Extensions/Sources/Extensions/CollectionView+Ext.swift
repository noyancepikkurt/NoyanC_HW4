//
//  CollectionView+Ext.swift
//  
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit

@available(iOS 13.0, *)
public extension UICollectionView {
    func register(cellType: UICollectionViewCell.Type) {
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else { fatalError("error")}
        return cell
    }
}
