//
//  ContentListingModule.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//
import Foundation
import UIKit

// MARK: - router

protocol ContentListingRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter

protocol ContentListingPresenterRouterInterface: PresenterRouterInterface {

}

protocol ContentListingPresenterInteractorInterface: PresenterInteractorInterface {
    func onFetchingGridContentSuccess(gridContent: GridContentController.GridContentResponse)
    func onFetchingGridContentFailed(title: String, message: String)
}

protocol ContentListingPresenterViewInterface: PresenterViewInterface {
    func getGridContentBy(categoryKey: String, page: Int)
}

// MARK: - interactor

protocol ContentListingInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchGridContentBy(categoryKey: String, page: Int)
}

// MARK: - view

protocol ContentListingViewPresenterInterface: ViewPresenterInterface {
    func onFetchingGridContentSuccess(gridContent: [Content])
    func onFetchingGridContentFailed(title: String, message: String)
}


// MARK: - module builder

final class ContentListingModule: ModuleInterface {

    typealias View = ContentListingView
    typealias Presenter = ContentListingPresenter
    typealias Router = ContentListingRouter
    typealias Interactor = ContentListingInteractor

    func build(category: CategoryController.Categories?, movieContent: MovieContentController.MovieContents?, type: ContentListingType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "ContentListingView") as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.type = type
        
        (type == .list) ? (view.movieContent = movieContent) : (view.category = category)

        return view
    }
}
