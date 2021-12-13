//
//  MainPresenter.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation
import UIKit

final class MainPresenter: PresenterInterface {

    var router: MainRouterPresenterInterface!
    var interactor: MainInteractorPresenterInterface!
    weak var view: MainViewPresenterInterface!

}

extension MainPresenter: MainPresenterRouterInterface {

}

extension MainPresenter: MainPresenterInteractorInterface {

    func onFetchingCategorySuccess(category: CategoryController.CategoryResponse) {
        view.onCategoryListReady(category: category.data)
    }
    
    func onFetchingDataFailed(title: String, message: String) {
        view.onFetchingDataFailed(title: title, message: message)
    }
    
}

extension MainPresenter: MainPresenterViewInterface {

    func getCategory() {
        interactor.fetchCategory()
    }
    
    func embedCategorizedContentListingView(at containerView: UIView, with category: CategoryController.Categories) {
        router.addCategorizedContentListingView(at: containerView, with: category)
    }
    
    func pushToWatchLaterView() {
        router.goToWatchLaterView()
    }
    
    func pushToCategoryListingView(category: [CategoryController.Categories]) {
        router.goToCategoryListingView(category: category)
    }
    
}
