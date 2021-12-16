//
//  ContentDescriptionModule.swift
//  ContentDescription
//
//  Created by Aung Chan Nyein on 12/16/21.
//
import Foundation
import UIKit

// MARK: - router

protocol ContentDescriptionRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter

protocol ContentDescriptionPresenterRouterInterface: PresenterRouterInterface {

}

protocol ContentDescriptionPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol ContentDescriptionPresenterViewInterface: PresenterViewInterface {
    
}

// MARK: - interactor

protocol ContentDescriptionInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol ContentDescriptionViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class ContentDescriptionModule: ModuleInterface {

    typealias View = ContentDescriptionView
    typealias Presenter = ContentDescriptionPresenter
    typealias Router = ContentDescriptionRouter
    typealias Interactor = ContentDescriptionInteractor

    func build(content: Content) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: ContentDescriptionView.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.content = content

        return view
    }
}
