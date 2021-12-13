//
//  CategorizedContentListingView.swift
//  CategorizedContentListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import UIKit

final class CategorizedContentListingView: UIViewController, ViewInterface {

    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CategorizedContentListingPresenterViewInterface!
    var parentView: UIView?
    private var loadingView = UIView()
    
    var category: CategoryController.Categories! {
        didSet {
            presenter.getContentBy(categoryKey: category.key)
        }
    }
    
    private var content: [MovieContentController.MovieContents] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerCategorizedTableViewCell()
        setupNotificationCenter()
    }
    
    // MARK: Objc Methods
    
    @objc private func didTapSegmentedControl(notification: Notification) {
        let category = notification.object as! CategoryController.Categories
        self.content = []
        self.loadingView = self.showLoadingView(at: self.parentView ?? self.view)
        presenter.getContentBy(categoryKey: category.key)
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        self.title = category.title
        loadingView = showLoadingView(at: parentView ?? self.view)
    }
    
    private func registerCategorizedTableViewCell() {
        tableView.register(UINib(nibName: CategorizedCell.identifier, bundle: nil), forCellReuseIdentifier: CategorizedCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(didTapSegmentedControl(notification:)), name: Notification.Name(Notification.Noti.didTapSegmentedControl), object: nil)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel,
            handler: nil
        ))
        
        alert.addAction(UIAlertAction(
            title: "Try Again",
            style: .default,
            handler: { _ in
                self.loadingView = self.showLoadingView(at: self.parentView ?? self.view)
                self.presenter.getContentBy(categoryKey: self.category.key)
            }
        ))
        
        present(alert, animated: true, completion: nil)
    }

}

extension CategorizedContentListingView: CategorizedContentListingViewPresenterInterface {
    
    func onContentListReady(content: [MovieContentController.MovieContents]) {
        hideLoadingView(at: loadingView)
        self.content = content
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}

extension CategorizedContentListingView: CategorizedCellInterface {
    
    func routeToContentListingView(contentList: MovieContentController.MovieContents) {
        presenter.pushToContentListingView(contentList: contentList)
    }
    
}

// MARK: Table View

extension CategorizedContentListingView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return content.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategorizedCell.identifier, for: indexPath) as! CategorizedCell
        cell.data(contentList: content[indexPath.row], listener: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item -> \(indexPath.row)")
    }
    
}
