//
//  MainRouter.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import UIKit

final class MainRouter: RouterInterface {

    weak var presenter: MainPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension MainRouter: MainRouterPresenterInterface {
    
    func addCategorizedContentListingView(at containerView: UIView, with category: CategoryController.Categories) {
        ViewEmbedder.addChild(
            childController: CategorizedContentListingModule().build(category: category, parentView: viewController?.view),
            parentController: viewController!,
            containerView: containerView
        )
    }

    func goToWatchLaterView() {
        let view = WatchLaterModule().build()
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
    func goToCategoryListingView(category: [CategoryController.Categories]) {
        let view = CategoryListingModule().build(category: category)
        viewController?.navigationController?.pushViewController(view, animated: true)
    }
    
}
