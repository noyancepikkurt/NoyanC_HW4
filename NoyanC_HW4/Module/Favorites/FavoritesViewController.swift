//
//  FavoritesViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 8.06.2023.
//

import UIKit
import Extensions

protocol FavoritesViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
}

final class FavoritesViewController: UIViewController {
    @IBOutlet private var tableView: UITableView!
    
    var presenter: FavoritesPresenterProtocol!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        presenter.viewDidLoad()
        setGradientBackground()
    }
}

extension FavoritesViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: FavoritesTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        if let song = presenter.songs(indexPath.row) {
            cell.cellPresenter = FavoritesCellPresenter(view: cell, songs: song)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if presenter.numberOfItem() == 0 {
            tableView.setEmptyView(title: AlertMessages.favoriteListTitle.rawValue,
                                   message: AlertMessages.favoriteListMessage.rawValue)
        } else {
            tableView.restore()
        }
        return presenter.numberOfItem()
    }
}

extension FavoritesViewController: FavoritesViewControllerProtocol {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: FavoritesTableViewCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // -> detail vc
    }
}
