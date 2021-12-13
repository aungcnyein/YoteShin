//
//  CategoryListingPresenter.swift
//  CategoryListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//

import Foundation

final class CategoryListingPresenter: PresenterInterface {

    var router: CategoryListingRouterPresenterInterface!
    var interactor: CategoryListingInteractorPresenterInterface!
    weak var view: CategoryListingViewPresenterInterface!

}

extension CategoryListingPresenter: CategoryListingPresenterRouterInterface {

}

extension CategoryListingPresenter: CategoryListingPresenterInteractorInterface {
    
}

extension CategoryListingPresenter: CategoryListingPresenterViewInterface {
    
    func pushToCategorizedContentListingView(category: CategoryController.Categories) {
        router.goToCategorizedContentListingView(category: category)
    }
    
    func pushToContentListingView(category: CategoryController.Categories) {
        router.goToContentListingView(category: category)
    }
    
}
