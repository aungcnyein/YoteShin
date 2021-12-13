//
//  WatchLaterRouter.swift
//  WatchLater
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import UIKit

final class WatchLaterRouter: RouterInterface {

    weak var presenter: WatchLaterPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension WatchLaterRouter: WatchLaterRouterPresenterInterface {

}