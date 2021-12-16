//
//  CategorizedContentListingModule.swift
//  CategorizedContentListing
//
//  Created by Aung Chan Nyein on 12/11/21.
//
import Foundation
import UIKit

// MARK: - router

protocol CategorizedContentListingRouterPresenterInterface: RouterPresenterInterface {
    func goToContentListingView(contentList: MovieContentController.MovieContents)
    func goToContentDetailView(content: Content)
}

// MARK: - presenter

protocol CategorizedContentListingPresenterRouterInterface: PresenterRouterInterface {

}

protocol CategorizedContentListingPresenterInteractorInterface: PresenterInteractorInterface {
    func onFetchingContentListSuccess(content: MovieContentController.MovieContentResponse)
    func onFetchingDataFailed(title: String, message: String)
}

protocol CategorizedContentListingPresenterViewInterface: PresenterViewInterface {
    func getContentBy(categoryKey: String)
    func pushToContentListingView(contentList: MovieContentController.MovieContents)
    func pushToContentDetailView(content: Content)
}

// MARK: - interactor

protocol CategorizedContentListingInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchContentBy(categoryKey: String)
}

// MARK: - view

protocol CategorizedContentListingViewPresenterInterface: ViewPresenterInterface {
    func onContentListReady(content: [MovieContentController.MovieContents])
    func onFetchingDataFailed(title: String, message: String)
}


// MARK: - module builder

final class CategorizedContentListingModule: ModuleInterface {

    typealias View = CategorizedContentListingView
    typealias Presenter = CategorizedContentListingPresenter
    typealias Router = CategorizedContentListingRouter
    typealias Interactor = CategorizedContentListingInteractor

    func build(category: CategoryController.Categories, parentView: UIView? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.category = category
        view.parentView = parentView

        return view
    }
}
