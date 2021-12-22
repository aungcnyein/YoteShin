//
//  PlayerView.swift
//  Player
//
//  Created by Aung Chan Nyein on 12/18/21.
//

import Foundation
import UIKit

final class PlayerView: UIViewController, ViewInterface {

    var presenter: PlayerPresenterViewInterface!
    var playableURL: String!
    static let identifier = "PlayerView"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TODO: Handle player
        presenter.startPlay(for: playableURL)
    }

}

extension PlayerView: PlayerViewPresenterInterface {

}
