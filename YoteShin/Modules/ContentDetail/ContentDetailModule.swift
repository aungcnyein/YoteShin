//
//  ContentDetailModule.swift
//  ContentDetail
//
//  Created by Aung Chan Nyein on 12/13/21.
//
import Foundation
import UIKit

// MARK: - router

protocol ContentDetailRouterPresenterInterface: RouterPresenterInterface {
    func addContentListingView(at containerView: UIView, with content: Content)
    func addContentDescriptionView(at containerView: UIView, with content: Content)
    func addEpisodeContentListingView(at containerView: UIView, with content: Content)
}

// MARK: - presenter

protocol ContentDetailPresenterRouterInterface: PresenterRouterInterface {

}

protocol ContentDetailPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol ContentDetailPresenterViewInterface: PresenterViewInterface {
    func embedContentListingView(at containerView: UIView, with content: Content)
    func embedContentDescriptionView(at containerView: UIView, with content: Content)
    func embedEpisodeContentListingView(at containerView: UIView, with content: Content)
}

// MARK: - interactor

protocol ContentDetailInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol ContentDetailViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class ContentDetailModule: ModuleInterface {

    typealias View = ContentDetailView
    typealias Presenter = ContentDetailPresenter
    typealias Router = ContentDetailRouter
    typealias Interactor = ContentDetailInteractor

    func build(content: Content, type: ContentType) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.content = content
        view.type = type

        return view
    }
}
