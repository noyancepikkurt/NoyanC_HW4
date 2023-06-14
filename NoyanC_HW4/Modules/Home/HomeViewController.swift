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
    @IBOutlet private var featuredCollectionView: UICollectionView!
    @IBOutlet private var recentlyCollectionView: UICollectionView!
    @IBOutlet private var pageControl: UIPageControl!
    @IBOutlet private var recenlySearchLabel: UILabel!
    private var currentPage = 0
    
    var presenter: HomePresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupRecentlyCollectionView()
        setGradientBackground()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter.viewDidLoad()
        recentlyCollectionView.reloadData()
    }
    
    private func setupRecentlyCollectionView() {
        let designPopular: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        designPopular.scrollDirection = .vertical
        designPopular.minimumLineSpacing = 16
        designPopular.minimumInteritemSpacing = 4
        let collectionViewWidth = recentlyCollectionView.frame.size.width
        let popularCellWidth = (collectionViewWidth) / 2 - 20
        let cellHeight = recentlyCollectionView.frame.size.height / 2.1
        designPopular.itemSize = CGSize(width: popularCellWidth, height: cellHeight)
        recentlyCollectionView.collectionViewLayout = designPopular
        recentlyCollectionView.contentInsetAdjustmentBehavior = .never
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == featuredCollectionView {
            let cell = collectionView.dequeCell(cellType: FeaturedCollectionViewCell.self, indexPath: indexPath)
            guard let featuredModel = presenter.featuredModel else { return UICollectionViewCell()}
            cell.setup(featuredModel[indexPath.item].image!)
            return cell
        } else {
            let cell = collectionView.dequeCell(cellType: RecentlySearchCollectionViewCell.self, indexPath: indexPath)
            if let songs = presenter.songs(indexPath.item) {
                cell.cellPresenter = RecentlySearchPresenter(view: cell, songDetail: songs)
            }
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == featuredCollectionView {
            guard let imageArrayCount = presenter.featuredModel?.count else { return 0}
            return imageArrayCount
        } else {
            if presenter.numberOfItems() == 0 {
                recentlyCollectionView.setEmptyView(title: "You have no recent searches", message: "Your recent searches will be displayed here")
                recenlySearchLabel.isHidden = true
            } else {
                recentlyCollectionView.restore()
                recenlySearchLabel.isHidden = false
            }
            return presenter.numberOfItems()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == featuredCollectionView {
            FeaturedEntity.albumName = presenter.featuredModel?[indexPath.item].albumName
            presenter.didSelectRowAtAlbums(index: indexPath.row)
        } else {
            presenter.didSelectRowAt(index: indexPath.row)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width - 30
        currentPage = Int(scrollView.contentOffset.x / width)
        pageControl.currentPage = currentPage
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == featuredCollectionView {
            let cellWidth = collectionView.frame.size.width - 10
            let cellHeight = collectionView.frame.size.height
            let itemSize = CGSize(width: cellWidth, height: cellHeight)
            return itemSize
        } else {
            return CGSize(width: 152, height: 184)
        }
    }
}

extension HomeViewController: HomeViewControllerProtocol {
    func registerCollectionViews() {
        featuredCollectionView.register(cellType: FeaturedCollectionViewCell.self)
        recentlyCollectionView.register(cellType: RecentlySearchCollectionViewCell.self )
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.recentlyCollectionView.reloadData()
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


