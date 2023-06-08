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

final class SearchViewController: UIViewController, LoadingShowable {
    @IBOutlet var searchTextField: CustomTextField!
    @IBOutlet var tableView: UITableView!
    private var searchDelayInterval: TimeInterval = 0.7
    private var searchTimer: Timer?
    
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setGradientBackground()
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
        tableView.isHidden = true
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            self.tableView.reloadData()
            
            if self.presenter.numberOfItems() > 0 {
                self.tableView.isHidden = false
            } else {
                self.tableView.isHidden = true
            }
        }
    }
    
    func showError(_ message: String) {
        UIAlertController.alertMessage(title: AlertMessages.error.rawValue, message: message, vc: self)
    }
    
    func showLoadingView() {
        //        showLoading(in: self.tableView)
    }
    
    func hideLoadingView() {
        //        hideLoading()
    }
    
    func setTitle(_ title: String) {
        self.title = title
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelayInterval, repeats: false) { [weak self] _ in
            guard let searchText = textField.text else { return }
            self?.presenter.fetchSongsFilter(with: searchText)
        }
    }
}
