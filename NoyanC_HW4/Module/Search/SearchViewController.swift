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
}

final class SearchViewController: UIViewController, LoadingShowable {
    @IBOutlet private var searchTextField: CustomTextField!
    @IBOutlet private var tableView: UITableView!
    private var searchDelayInterval: TimeInterval = 0.85
    private var searchTimer: Timer?
    
    var presenter: SearchPresenterProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        presenter?.viewDidLoad()
        setupNavigationBar()
        setGradientBackground()
        searchTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        presenter.stopAudio()
    }
    
    @objc func buttonTapped(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? SearchTableViewCell,
              let indexPath = tableView.indexPath(for: cell) else { return }
        cell.audioButtonAction()
        for visibleCell in tableView.visibleCells {
            if let visibleIndexPath = tableView.indexPath(for: visibleCell),
               visibleIndexPath != indexPath,
               let unselectedCell = tableView.cellForRow(at: visibleIndexPath) as? SearchTableViewCell
            {
                unselectedCell.stopAudio()
            }
        }
    }
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .white
        navigationItem.backButtonTitle = ""
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: SearchTableViewCell.self, indexPath: indexPath)
        cell.selectionStyle = .none
        
        if let songs = presenter.songs(indexPath.row) {
            cell.cellPresenter = SearchCellPresenter(view: cell, song: songs)
        }
        
        cell.audioButtonImage.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        presenter.numberOfItems()
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
    
    func hideLoadingView() {
        self.hideLoading()
    }
    
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        for cell in tableView.visibleCells {
//            guard let cell = cell as? SearchTableViewCell else { return }
//            if cell.cellPresenter.isAudioPlaying {
//                cell.audioButtonAction()
//            }
//        }
//    }
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
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(withTimeInterval: searchDelayInterval, repeats: false) { [weak self] _ in
            guard let searchText = textField.text else { return }
            self?.presenter.fetchSongsFilter(with: searchText)
            if searchText != "" {
                UserDefaultsManager.shared.saveLastSearchText(searchText)
            }
            self?.presenter.stopAudio()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
