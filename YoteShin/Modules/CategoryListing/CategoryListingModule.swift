//
//  CategoryListingModule.swift
//  CategoryListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//
import Foundation
import UIKit

// MARK: - router

protocol CategoryListingRouterPresenterInterface: RouterPresenterInterface {
    func goToCategorizedContentListingView(category: CategoryController.Categories)
    func goToContentListingView(category: CategoryController.Categories)
}

// MARK: - presenter

protocol CategoryListingPresenterRouterInterface: PresenterRouterInterface {

}

protocol CategoryListingPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol CategoryListingPresenterViewInterface: PresenterViewInterface {
    func pushToCategorizedContentListingView(category: CategoryController.Categories)
    func pushToContentListingView(category: CategoryController.Categories)
}

// MARK: - interactor

protocol CategoryListingInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol CategoryListingViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class CategoryListingModule: ModuleInterface {

    typealias View = CategoryListingView
    typealias Presenter = CategoryListingPresenter
    typealias Router = CategoryListingRouter
    typealias Interactor = CategoryListingInteractor

    func build(category: [CategoryController.Categories]) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.category = category

        return view
    }
}
