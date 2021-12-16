//
//  EpisodeContentListingModule.swift
//  EpisodeContentListing
//
//  Created by Aung Chan Nyein on 12/16/21.
//
import Foundation
import UIKit

// MARK: - router

protocol EpisodeContentListingRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter

protocol EpisodeContentListingPresenterRouterInterface: PresenterRouterInterface {

}

protocol EpisodeContentListingPresenterInteractorInterface: PresenterInteractorInterface {
    func onFetchingEpisodeContentSuccess(episodeContent: EpisodeContentController.EpisodeContentResponse)
    func onFetchingDataFailed(title: String, message: String)
}

protocol EpisodeContentListingPresenterViewInterface: PresenterViewInterface {
    func getEpisodeContentBy(contentID: String, page: Int)
}

// MARK: - interactor

protocol EpisodeContentListingInteractorPresenterInterface: InteractorPresenterInterface {
    func fetchEpisodeContentBy(contentID: String, page: Int)
}

// MARK: - view

protocol EpisodeContentListingViewPresenterInterface: ViewPresenterInterface {
    func onFetchingEpisodeContentSuccess(episodeContent: [EpisodeContent])
    func onFetchingDataFailed(title: String, message: String)
}


// MARK: - module builder

final class EpisodeContentListingModule: ModuleInterface {

    typealias View = EpisodeContentListingView
    typealias Presenter = EpisodeContentListingPresenter
    typealias Router = EpisodeContentListingRouter
    typealias Interactor = EpisodeContentListingInteractor

    func build(content: Content) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.content = content

        return view
    }
}
