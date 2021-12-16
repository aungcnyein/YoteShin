//
//  CategoryListingRouter.swift
//  CategoryListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation
import UIKit

final class CategoryListingRouter: RouterInterface {

    weak var presenter: CategoryListingPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension CategoryListingRouter: CategoryListingRouterPresenterInterface {

    func goToCategorizedContentListingView(category: CategoryController.Categories) {
        let view = CategorizedContentListingModule().build(category: category)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToContentListingView(category: CategoryController.Categories) {
        let categorizedContent = CategorizedContent(category: category)
        let view = ContentListingModule().build(categorizedContent: categorizedContent, type: .grid)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
