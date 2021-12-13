//
//  WatchLaterInteractor.swift
//  WatchLater
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation

final class WatchLaterInteractor: InteractorInterface {

    weak var presenter: WatchLaterPresenterInteractorInterface!
}

extension WatchLaterInteractor: WatchLaterInteractorPresenterInterface {

}
