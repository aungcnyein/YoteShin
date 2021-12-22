//
//  MainModule.swift
//  Main
//
//  Created by Aung Chan Nyein on 11/17/21.
//
import Foundation
import UIKit

// MARK: - router

protocol MainRouterPresenterInterface: RouterPresenterInterface {
    func addCategorizedContentListingView(at containerView: UIView, with category: CategoryController.Categories)
    func addContentListingView(at containerView: UIView, with category: CategoryController.Categories)
    func goToWatchLaterView()
}

// MARK: - presenter

protocol MainPresenterRouterInterface: PresenterRouterInterface {

}

protocol MainPresenterInteractorInterface: PresenterInteractorInterface {
    func onFetchingCategorySuccess(category: CategoryController.CategoryResponse)
    func onFetchingDataFailed(title: String, message: String)
}

protocol MainPresenterViewInterface: PresenterViewInterface {
    func getCategory()
    func embedCategorizedContentListingView(at containerView: UIView, with category: CategoryController.Categories)
    func embedContentListingView(at containerView: UIView, with category: CategoryController.Categories)
    func pushToWatchLaterView()
}

// MARK: - interactor

protocol MainInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchCategory()
}

// MARK: - view

protocol MainViewPresenterInterface: ViewPresenterInterface {
    func onCategoryListReady(category: [CategoryController.Categories])
    func onFetchingDataFailed(title: String, message: String)
}


// MARK: - module builder

final class MainModule: ModuleInterface {

    typealias View = MainView
    typealias Presenter = MainPresenter
    typealias Router = MainRouter
    typealias Interactor = MainInteractor

    func build() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view

        return view
    }
}
