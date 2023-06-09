//
//  HomeViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Extensions

protocol HomeViewControllerProtocol: AnyObject {
    func registerCollectionViews()
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
}

final class HomeViewController: UIViewController, LoadingShowable {
    @IBOutlet var featuredCollectionView: UICollectionView!
    @IBOutlet var popularCollectionView: UICollectionView!
    private var imageArrayFeaturedCV: [UIImage]?
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        imageArrayConfig()
        setupCollectionViews()
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
        
        let designPopular: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        designPopular.scrollDirection = .vertical
        designPopular.minimumLineSpacing = 16
        designPopular.minimumInteritemSpacing = 4
        let collectionViewWidth = popularCollectionView.frame.size.width
        let popularCellWidth = (collectionViewWidth - 20) / 2
        let cellHeight = popularCollectionView.frame.size.height / 2.1
        designPopular.itemSize = CGSize(width: popularCellWidth, height: cellHeight)
        popularCollectionView.collectionViewLayout = designPopular
        popularCollectionView.contentInsetAdjustmentBehavior = .never
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
            let cell = collectionView.dequeCell(cellType: PopularCollectionViewCell.self, indexPath: indexPath)
            if let songs = presenter.songs(indexPath.item) {
                cell.cellPresenter = PopularCellPresenter(view: cell, songDetail: songs)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredCollectionView {
            guard let imageArrayCount = imageArrayFeaturedCV?.count else { return 0}
            return imageArrayCount
        } else {
            return presenter.numberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    
}

extension HomeViewController: HomeViewControllerProtocol {
    
    func registerCollectionViews() {
        featuredCollectionView.register(cellType: FeaturedCollectionViewCell.self)
        popularCollectionView.register(cellType: PopularCollectionViewCell.self )
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.popularCollectionView.reloadData()
            self.featuredCollectionView.reloadData()
        }
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
}


