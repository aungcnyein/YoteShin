//
//  CategoryListingView.swift
//  CategoryListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import UIKit

final class CategoryListingView: UIViewController, ViewInterface {

    // MARK: Properties
    
    @IBOutlet weak var tableView: UITableView!
    
    var presenter: CategoryListingPresenterViewInterface!
    static let identifier = "CategoryListingView"
    private let categoryListingCellReuseIdentifier = "CategoryListingCell"
    
    var category: [CategoryController.Categories]!

    // MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        registerCategorizedTableViewCell()
    }
    
    // MARK: Custom Methods
    
    private func configureUI() {
        self.title = "All Categories"
    }
    
    private func registerCategorizedTableViewCell() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: categoryListingCellReuseIdentifier)
        tableView.dataSource = self
        tableView.delegate = self
    }

}

extension CategoryListingView: CategoryListingViewPresenterInterface {
    
}

// MARK: Table View

extension CategoryListingView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return category.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: categoryListingCellReuseIdentifier, for: indexPath)
        
        var content = UIListContentConfiguration.cell()
        content.text = category[indexPath.row].title
        
        cell.contentConfiguration = content
        cell.accessoryType = .disclosureIndicator
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if category[indexPath.row].type == ContentListingType.list.description {
            presenter.pushToCategorizedContentListingView(category: category[indexPath.row])
        }
        
        if category[indexPath.row].type == ContentListingType.grid.description {
            presenter.pushToContentListingView(category: category[indexPath.row])
        }
        
    }
    
}
