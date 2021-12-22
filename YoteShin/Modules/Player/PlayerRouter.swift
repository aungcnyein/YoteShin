//
//  PlayerRouter.swift
//  Player
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation
import UIKit

final class PlayerRouter: RouterInterface {

    weak var presenter: PlayerPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension PlayerRouter: PlayerRouterPresenterInterface {

    func play(for url: String) {
        YoteShinPlayer.play(for: url, at: viewController!)
    }
    
}
