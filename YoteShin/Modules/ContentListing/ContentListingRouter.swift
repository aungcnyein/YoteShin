//
//  ContentListingRouter.swift
//  ContentListing
//
//  Created by Aung Chan Nyein on 12/10/21.
//

import Foundation
import UIKit

final class ContentListingRouter: RouterInterface {

    weak var presenter: ContentListingPresenterRouterInterface!

    weak var viewController: UIViewController?
}

extension ContentListingRouter: ContentListingRouterPresenterInterface {

}
