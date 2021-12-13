//
//  Interfaces.swift
//  YoteShin
//
//  Created by Aung Chan Nyein on 11/17/21.
//

import Foundation

// MARK: - interfaces

public protocol RouterPresenterInterface: AnyObject {
    
}

public protocol InteractorPresenterInterface: AnyObject {
    
}

public protocol PresenterRouterInterface: AnyObject {
    
}

public protocol PresenterInteractorInterface: AnyObject {
    
}

public protocol PresenterViewInterface: AnyObject {
    
}

public protocol ViewPresenterInterface: AnyObject {
    
}

// MARK: - viper

public protocol RouterInterface: RouterPresenterInterface {
    associatedtype PresenterRouter

    var presenter: PresenterRouter! { get set }
}

public protocol InteractorInterface: InteractorPresenterInterface {
    associatedtype PresenterInteractor
    
    var presenter: PresenterInteractor! { get set }
}

public protocol PresenterInterface: PresenterRouterInterface & PresenterInteractorInterface & PresenterViewInterface {
    associatedtype RouterPresenter
    associatedtype InteractorPresenter
    associatedtype ViewPresenter

    var router: RouterPresenter! { get set }
    var interactor: InteractorPresenter! { get set }
    var view: ViewPresenter! { get set }
}

public protocol ViewInterface: ViewPresenterInterface {
    associatedtype PresenterView
    
    var presenter: PresenterView! { get set }
}

public protocol EntityInterface {
    
}

// MARK: - module

public protocol ModuleInterface {

    associatedtype View where View: ViewInterface
    associatedtype Presenter where Presenter: PresenterInterface
    associatedtype Router where Router: RouterInterface
    associatedtype Interactor where Interactor: InteractorInterface
    
    func assemble(view: View, presenter: Presenter, router: Router, interactor: Interactor)
}

public extension ModuleInterface {

    func assemble(view: View, presenter: Presenter, router: Router, interactor: Interactor) {
        view.presenter = (presenter as! Self.View.PresenterView)
        
        presenter.view = (view as! Self.Presenter.ViewPresenter)
        presenter.interactor = (interactor as! Self.Presenter.InteractorPresenter)
        presenter.router = (router as! Self.Presenter.RouterPresenter)
        
        interactor.presenter = (presenter as! Self.Interactor.PresenterInteractor)
        
        router.presenter = (presenter as! Self.Router.PresenterRouter)
    }
}
