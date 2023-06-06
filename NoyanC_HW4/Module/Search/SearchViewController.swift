//
//  SearchViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 6.06.2023.
//

import UIKit
import Extensions

protocol SearchViewControllerProtocol: AnyObject {
    func setupTableView()
    func reloadData()
    func showError(_ message: String)
    func showLoadingView()
    func hideLoadingView()
    func setTitle(_ title: String)
}

final class SearchViewController: UIViewController {
    @IBOutlet var searchTextField: CustomTextField!
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
    }
    
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: SearchTableViewCell.self, indexPath: indexPath)
        
//        if let news = presenter.songs(indexPath.row) {
//            cell.cellPresenter = NewsCellPresenter(view: cell, news: news)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
    }
}


extension SearchViewController: SearchViewControllerProtocol {
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: SearchTableViewCell.self)
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
        }
    }
    
    func showError(_ message: String) {
        //ALERT
    }
    
    func showLoadingView() {
        //showloading
    }
    
    func hideLoadingView() {
        //hideloading
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
    
    
}

