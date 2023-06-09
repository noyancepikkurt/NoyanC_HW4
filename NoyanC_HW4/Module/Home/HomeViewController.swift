//
//  HomeViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Extensions

final class HomeViewController: UIViewController {
    @IBOutlet var featuredCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    private var imageArrayFeaturedCV: [UIImage]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageArrayConfig()
        setupCollectionViews()
        registerCollectionViews()
        setGradientBackground()
    }
    
    private func setupCollectionViews() {
        let design: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        design.scrollDirection = .horizontal
        design.collectionView?.isPagingEnabled = true
        design.minimumLineSpacing = 10
        let cellWidth = self.featuredCollectionView.frame.size.width - (design.minimumLineSpacing)
        design.itemSize = CGSize(width: cellWidth, height: cellWidth * 0.5)
        featuredCollectionView!.collectionViewLayout = design
    }
    
    private func registerCollectionViews() {
        featuredCollectionView.register(cellType: FeaturedCollectionViewCell.self)
    }
    
    private func imageArrayConfig() {
        imageArrayFeaturedCV = [UIImage(named: "daft_punk")!, UIImage(named: "pinhani")!, UIImage(named: "eminem")!,UIImage(named: "beatles")!]
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollectionView {
            let cell = collectionView.dequeCell(cellType: FeaturedCollectionViewCell.self, indexPath: indexPath)
            guard let imageArrayFeaturedCV else { return UICollectionViewCell()}
            cell.setup(imageArrayFeaturedCV[indexPath.item])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredCollectionView {
            guard let imageArrayCount = imageArrayFeaturedCV?.count else { return 0}
            return imageArrayCount
        } else {
            return 0
        }
    }
}
