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
    func goToContentDetailView(content: Content, type: ContentType, shouldEmbedNavigation: Bool)
}

// MARK: - presenter

protocol ContentListingPresenterRouterInterface: PresenterRouterInterface {

}

protocol ContentListingPresenterInteractorInterface: PresenterInteractorInterface {
    func onFetchingGridContentSuccess(gridContent: GridContentController.GridContentResponse)
    func onFetchingRelatedContentSuccess(relatedContent: RelatedContentController.RelatedContentResponse)
    func onFetchingDataFailed(title: String, message: String)
}

protocol ContentListingPresenterViewInterface: PresenterViewInterface {
    func getGridContentBy(categoryKey: String, page: Int)
    func getRelatedContentBy(contentID: String)
    func pushToContentDetailView(content: Content, type: ContentType, shouldEmbedNavigation: Bool)
}

// MARK: - interactor

protocol ContentListingInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchGridContentBy(categoryKey: String, page: Int)
    func fetchRelatedContentBy(contentID: String)
}

// MARK: - view

protocol ContentListingViewPresenterInterface: ViewPresenterInterface {
    func onFetchingGridContentSuccess(gridContent: [Content])
    func onFetchingRelatedContentSuccess(relatedContent: RelatedContentController.RelatedContents)
    func onFetchingDataFailed(title: String, message: String)
}


// MARK: - module builder

final class ContentListingModule: ModuleInterface {

    typealias View = ContentListingView
    typealias Presenter = ContentListingPresenter
    typealias Router = ContentListingRouter
    typealias Interactor = ContentListingInteractor

    func build(categorizedContent: CategorizedContent, type: ContentListingType, parentView: UIView? = nil) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.categorizedContent = categorizedContent
        view.parentView = parentView
        view.type = type

        return view
    }
}
