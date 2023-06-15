//
//  AlbumViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import UIKit

protocol AlbumViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showLoadingView()
    func hideLoadingView()
}

final class AlbumViewController: UIViewController, LoadingShowable {
    @IBOutlet private weak var albumTitleLabel: UILabel!
    @IBOutlet private var albumTableView: UITableView!
    
    var presenter: AlbumPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        setGradientBackground()
        setupNavigationBar()
        setupAlbumLabel()
    }
    
    private func setupAlbumLabel() {
        guard let albumName = FeaturedEntity.albumName else { return }
        albumTitleLabel.text = "\(albumName) Album"
    }
    
    private func setupNavigationBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationItem.backButtonTitle = ""
    }
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let numberOfItems = presenter?.numberOfItem() else { return 0 }
        return numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: AlbumTableViewCell.self, indexPath: indexPath)
        if let songs = presenter?.albumSongs(indexPath.row) {
            cell.cellPresenter = AlbumCellPresenter(view: cell, songDetail: songs)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.didSelectRowAt(index: indexPath.row)
    }
}

extension AlbumViewController: AlbumViewControllerProtocol {
    func setupTableView() {
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.register(cellType: AlbumTableViewCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.albumTableView.reloadData()
        }
    }
    
    func showLoadingView() {
        self.showLoading()
    }
    
    func hideLoadingView() {
        self.hideLoading()
    }
}
