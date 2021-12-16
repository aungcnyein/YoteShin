//
//  WatchLaterModule.swift
//  WatchLater
//
//  Created by Aung Chan Nyein on 12/10/21.
//
import Foundation
import UIKit

// MARK: - router

protocol WatchLaterRouterPresenterInterface: RouterPresenterInterface {

}

// MARK: - presenter

protocol WatchLaterPresenterRouterInterface: PresenterRouterInterface {

}

protocol WatchLaterPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol WatchLaterPresenterViewInterface: PresenterViewInterface {
    
}

// MARK: - interactor

protocol WatchLaterInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol WatchLaterViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class WatchLaterModule: ModuleInterface {

    typealias View = WatchLaterView
    typealias Presenter = WatchLaterPresenter
    typealias Router = WatchLaterRouter
    typealias Interactor = WatchLaterInteractor

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
