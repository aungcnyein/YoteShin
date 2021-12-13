//
//  WatchLaterPresenter.swift
//  WatchLater
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation

final class WatchLaterPresenter: PresenterInterface {

    var router: WatchLaterRouterPresenterInterface!
    var interactor: WatchLaterInteractorPresenterInterface!
    weak var view: WatchLaterViewPresenterInterface!

}

extension WatchLaterPresenter: WatchLaterPresenterRouterInterface {

}

extension WatchLaterPresenter: WatchLaterPresenterInteractorInterface {

}

extension WatchLaterPresenter: WatchLaterPresenterViewInterface {

}
