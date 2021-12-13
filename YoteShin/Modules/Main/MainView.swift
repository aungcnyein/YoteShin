//
//  MainView.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import UIKit

final class MainView: UIViewController, ViewInterface {
    
    // MARK: Properties
    
    @IBOutlet weak var containerView: UIView!
    
    var presenter: MainPresenterViewInterface!
    private var segmentedControl: UISegmentedControl!
    private var segmentedItems: [String] = []
    private var loadingView = UIView()
    
    private var category: [CategoryController.Categories] = [] {
        didSet {
            navigationController?.navigationBar.isUserInteractionEnabled = true
            
            for index in 0...3 {
                self.segmentedItems.append(category[index].title)
            }

            setupSegmentedControl()
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
    
    @objc private func didTapSegmentedControl(sender: UISegmentedControl) {
        NotificationCenter.default.post(name: Notification.Name(Notification.Noti.didTapSegmentedControl), object: category[sender.selectedSegmentIndex])
    }
    
    @objc private func didTapWatchLaterButton() {
        presenter.pushToWatchLaterView()
    }
    
    @objc private func didTapCategoriesButton() {
        presenter.pushToCategoryListingView(category: category)
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        self.title = "Home"
        navigationController?.navigationBar.tintColor = .red
        navigationController?.navigationBar.isUserInteractionEnabled = false
        loadingView = showLoadingView(at: self.view)
    }
    
    private func setupSegmentedControl() {
        segmentedControl = NoSwipeSegmentedControl(items: segmentedItems)
        segmentedControl.selectedSegmentIndex = 0
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        // segmentedControl.apportionsSegmentWidthsByContent = true
        segmentedControl.addTarget(self, action: #selector(didTapSegmentedControl(sender:)), for: .valueChanged)
        
        self.view.addSubview(segmentedControl)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 8),
            segmentedControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            segmentedControl.heightAnchor.constraint(equalToConstant: 35),
            
            containerView.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 16)
        ])
    }
    
    private func setupNavigationBarItem() {
        let watchLaterButton = UIButton(type: .custom)
        watchLaterButton.setImage(UIImage(named: "ic_watchlater"), for: .normal)
        watchLaterButton.addTarget(self, action: #selector(didTapWatchLaterButton), for: .touchUpInside)
        
        let categoriesButton = UIButton(type: .custom)
        categoriesButton.setImage(UIImage(named: "ic_categories"), for: .normal)
        categoriesButton.addTarget(self, action: #selector(didTapCategoriesButton), for: .touchUpInside)
        
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(customView: categoriesButton),
            UIBarButtonItem(customView: watchLaterButton)
        ]
        
        NSLayoutConstraint.activate([
            watchLaterButton.widthAnchor.constraint(equalToConstant: 26),
            watchLaterButton.heightAnchor.constraint(equalToConstant: 26),
            
            categoriesButton.widthAnchor.constraint(equalToConstant: 26),
            categoriesButton.heightAnchor.constraint(equalToConstant: 26)
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
        
        presenter.embedCategorizedContentListingView(at: containerView, with: category[segmentedControl.selectedSegmentIndex])
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        hideLoadingView(at: loadingView)
        showAlert(title: title, message: message)
    }
    
}
