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
    func setTitle(_ title: String)
}

final class SearchViewController: UIViewController {
    @IBOutlet var searchTextField: CustomTextField!
    @IBOutlet var tableView: UITableView!
    
    var presenter: SearchPresenterProtocol!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
        searchTextField.delegate = self
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: SearchTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        
        if let songs = presenter.songs(indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, song: songs)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfItems()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelectRowAt(index: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
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
        UIAlertController.alertMessage(title: "Error", message: message, vc: self)
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

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        presenter.fetchSongsFilter(with: textField.text!)
    }
}
