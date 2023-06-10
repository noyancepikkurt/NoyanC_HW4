//
//  AlbumViewController.swift
//  NoyanC_HW4
//
//  Created by Noyan Çepikkurt on 10.06.2023.
//

import UIKit

protocol AlbumViewControllerProtocol: AnyObject {
    
}

final class AlbumViewController: UIViewController {
    
    @IBOutlet var albumTableView: UITableView!
    
    var presenter: AlbumPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        guard let tableView = albumTableView else { return }
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(cellType: AlbumTableViewCell.self)
    }
}

extension AlbumViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(cellType: AlbumTableViewCell.self, indexPath: indexPath)
        return cell
    }
}

extension AlbumViewController: AlbumViewControllerProtocol {
    
}
