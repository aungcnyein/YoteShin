//
//  PlayerInteractor.swift
//  Player
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation

final class PlayerInteractor: InteractorInterface {

    weak var presenter: PlayerPresenterInteractorInterface!
}

extension PlayerInteractor: PlayerInteractorPresenterInterface {

}
