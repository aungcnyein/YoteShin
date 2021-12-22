//
//  PlayerModule.swift
//  Player
//
//  Created by Aung Chan Nyein on 12/18/21.
//
import Foundation
import UIKit

// MARK: - router

protocol PlayerRouterPresenterInterface: RouterPresenterInterface {
    func play(for url: String)
}

// MARK: - presenter

protocol PlayerPresenterRouterInterface: PresenterRouterInterface {

}

protocol PlayerPresenterInteractorInterface: PresenterInteractorInterface {

}

protocol PlayerPresenterViewInterface: PresenterViewInterface {
    func startPlay(for url: String)
}

// MARK: - interactor

protocol PlayerInteractorPresenterInterface: InteractorPresenterInterface {

}

// MARK: - view

protocol PlayerViewPresenterInterface: ViewPresenterInterface {

}


// MARK: - module builder

final class PlayerModule: ModuleInterface {

    typealias View = PlayerView
    typealias Presenter = PlayerPresenter
    typealias Router = PlayerRouter
    typealias Interactor = PlayerInteractor

    func build(playableURL: String) -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: View.identifier) as! View
        let interactor = Interactor()
        let presenter = Presenter()
        let router = Router()

        self.assemble(view: view, presenter: presenter, router: router, interactor: interactor)

        router.viewController = view
        
        view.playableURL = playableURL

        return view
    }
}
