//
//  PlayerPresenter.swift
//  Player
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation

final class PlayerPresenter: PresenterInterface {

    var router: PlayerRouterPresenterInterface!
    var interactor: PlayerInteractorPresenterInterface!
    weak var view: PlayerViewPresenterInterface!

}

extension PlayerPresenter: PlayerPresenterRouterInterface {

}

extension PlayerPresenter: PlayerPresenterInteractorInterface {

}

extension PlayerPresenter: PlayerPresenterViewInterface {

    func startPlay(for url: String) {
        router.play(for: url)
    }
    
}
