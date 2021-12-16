//
//  EpisodeContentListingRouter.swift
//  EpisodeContentListing
//
//  Created by Aung Chan Nyein on 12/16/21.
//

import Foundation
import UIKit

final class EpisodeContentListingRouter: RouterInterface {

    weak var presenter: EpisodeContentListingPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension EpisodeContentListingRouter: EpisodeContentListingRouterPresenterInterface {

}