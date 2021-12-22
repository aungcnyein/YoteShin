//
//  MainView.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import UIKit
import BTNavigationDropdownMenu

final class MainView: UIViewController, ViewInterface {
    
    // MARK: Properties
    
    @IBOutlet weak var containerView: UIView!
    
    var presenter: MainPresenterViewInterface!
    static let identifier = "MainView"
    private var loadingView = UIView()
    private var dropDownItems: [String] = []
    
    private var category: [CategoryController.Categories] = [] {
        didSet {
            navigationController?.navigationBar.isUserInteractionEnabled = true
            setupNavigationDropDownMenu()
        }
    }

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupNavigationBarItem()
        
        guard presenter != nil else { return }
        presenter.getCategory()
    }
    
    // MARK: Objc Methods
    
    @objc private func didTapWatchLaterButton() {
        presenter.pushToWatchLaterView()
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.isUserInteractionEnabled = false
        loadingView = showLoadingView(at: self.view)
    }
    
    private func setupNavigationDropDownMenu() {
        for index in 0..<category.count {
            self.dropDownItems.append(category[index].title)
        }
        
        let menuView = BTNavigationDropdownMenu(navigationController: self.navigationController, containerView: self.navigationController!.view, title: BTTitle.index(0), items: dropDownItems)
        
        menuView.cellBackgroundColor = .systemBackground
        menuView.cellSeparatorColor = .systemBackground
        menuView.cellSelectionColor = .secondarySystemBackground
        menuView.arrowTintColor = .systemRed
        menuView.menuTitleColor = .systemRed
        menuView.maskBackgroundOpacity = 0.7
        
        self.navigationItem.titleView = menuView
        
        menuView.didSelectItemAtIndexHandler = {(indexPath: Int) -> () in
            if self.category[indexPath].type == ContentListingType.list.description {
                self.presenter.embedCategorizedContentListingView(at: self.containerView, with: self.category[indexPath])
            }
            
            if self.category[indexPath].type == ContentListingType.grid.description {
                self.presenter.embedContentListingView(at: self.containerView, with: self.category[indexPath])
            }
        }
    }
    
    private func setupNavigationBarItem() {
        let watchLaterButton = UIButton(type: .custom)
        watchLaterButton.setImage(UIImage(named: "ic_watchlater"), for: .normal)
        watchLaterButton.addTarget(self, action: #selector(didTapWatchLaterButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: watchLaterButton)
        
        NSLayoutConstraint.activate([
            watchLaterButton.widthAnchor.constraint(equalToConstant: 26),
            watchLaterButton.heightAnchor.constraint(equalToConstant: 26)
        ])
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(
            title: "Try Again",
            style: .default,
            handler: { _ in
                self.loadingView = self.showLoadingView(at: self.view)
                self.presenter.getCategory()
            })
        )
        
        present(alert, animated: true, completion: nil)
    }

}

extension MainView: MainViewPresenterInterface {

    func onCategoryListReady(category: [CategoryController.Categories]) {
        hideLoadingView(at: loadingView)
        self.category = category
        
        presenter.embedCategorizedContentListingView(at: containerView, with: category[0])
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}
